import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../models/tables.dart';

const _complianceTypes = {
  'revenue_license': 'Revenue License',
  'insurance': 'Insurance',
  'emission_test': 'Emission Test',
};

class ComplianceScreen extends ConsumerWidget {
  const ComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(activeVehicleProvider).valueOrNull;
    final logs = ref.watch(complianceLogsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Compliance Records')),
      floatingActionButton: vehicle == null
          ? null
          : FloatingActionButton(
              onPressed: () => _showAddDialog(context, ref, vehicle),
              child: const Icon(Icons.add),
            ),
      body: logs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (items) => items.isEmpty
            ? const Center(child: Text('No compliance records yet'))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final log = items[index];
                  return ListTile(
                    title: Text(_complianceTypes[log.type] ?? log.type),
                    subtitle: Text('Expires ${_formatDate(log.expiresAt)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _delete(ref, log),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    Vehicle vehicle,
  ) async {
    final result = await showDialog<(String, DateTime)>(
      context: context,
      builder: (_) => const _AddComplianceDialog(),
    );
    if (result == null) return;

    final (type, expiry) = result;
    final db = ref.read(databaseProvider);
    final id = await db.into(db.complianceLogs).insert(
          ComplianceLogsCompanion.insert(
            vehicleId: vehicle.id,
            type: type,
            expiresAt: expiry.millisecondsSinceEpoch,
          ),
        );

    final log = await (db.select(db.complianceLogs)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    final alerts = ref.read(complianceAlertServiceProvider);
    await alerts.init();
    await alerts.scheduleFor(log, vehicle.plateNumber);
    await alerts.refreshBadge();
  }

  Future<void> _delete(WidgetRef ref, ComplianceLog log) async {
    final db = ref.read(databaseProvider);
    final alerts = ref.read(complianceAlertServiceProvider);
    await alerts.cancelFor(log.id);
    await (db.delete(db.complianceLogs)..where((t) => t.id.equals(log.id)))
        .go();
    await alerts.refreshBadge();
  }

  static String _formatDate(int millis) {
    final d = DateTime.fromMillisecondsSinceEpoch(millis);
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}

class _AddComplianceDialog extends StatefulWidget {
  const _AddComplianceDialog();

  @override
  State<_AddComplianceDialog> createState() => _AddComplianceDialogState();
}

class _AddComplianceDialogState extends State<_AddComplianceDialog> {
  String _type = _complianceTypes.keys.first;
  DateTime? _expiry;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiry ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _expiry = picked);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add compliance record'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _type,
            items: [
              for (final entry in _complianceTypes.entries)
                DropdownMenuItem(value: entry.key, child: Text(entry.value)),
            ],
            onChanged: (value) => setState(() => _type = value!),
            decoration: const InputDecoration(labelText: 'Type'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _pickDate,
            child: Text(
              _expiry == null
                  ? 'Pick expiry date'
                  : 'Expires ${_expiry!.year}-${_expiry!.month}-${_expiry!.day}',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _expiry == null
              ? null
              : () => Navigator.of(context).pop((_type, _expiry!)),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
