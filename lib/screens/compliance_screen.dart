import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../core/compliance_types.dart';
import '../core/providers.dart';
import '../models/tables.dart';
import '../services/document_storage_service.dart';
import 'document_preview_screen.dart';

typedef _AddComplianceResult = ({
  String type,
  DateTime expiry,
  double? cost,
  XFile? document,
});

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
                    leading: _DocumentThumbnail(
                      log: log,
                      onTap: () => _onThumbnailTap(context, ref, log),
                    ),
                    title: Text(complianceTypeLabels[log.type] ?? log.type),
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

  Future<void> _onThumbnailTap(
    BuildContext context,
    WidgetRef ref,
    ComplianceLog log,
  ) async {
    if (log.documentPath != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DocumentPreviewScreen(
            path: log.documentPath!,
            title: complianceTypeLabels[log.type] ?? log.type,
          ),
        ),
      );
      return;
    }

    final source = await _pickImageSource(context);
    if (source == null) return;

    final storage = DocumentStorageService();
    final file = await storage.pick(source);
    if (file == null) return;

    final path = await storage.save(file, prefix: log.type);
    final db = ref.read(databaseProvider);
    await (db.update(db.complianceLogs)..where((t) => t.id.equals(log.id)))
        .write(ComplianceLogsCompanion(documentPath: Value(path)));
  }

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    Vehicle vehicle,
  ) async {
    final result = await showDialog<_AddComplianceResult>(
      context: context,
      builder: (_) => const _AddComplianceDialog(),
    );
    if (result == null) return;

    String? documentPath;
    if (result.document != null) {
      documentPath = await DocumentStorageService()
          .save(result.document!, prefix: result.type);
    }

    final db = ref.read(databaseProvider);
    final id = await db.into(db.complianceLogs).insert(
          ComplianceLogsCompanion.insert(
            vehicleId: vehicle.id,
            type: result.type,
            expiresAt: result.expiry.millisecondsSinceEpoch,
            cost: Value(result.cost),
            documentPath: Value(documentPath),
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

Future<ImageSource?> _pickImageSource(BuildContext context) {
  return showModalBottomSheet<ImageSource>(
    context: context,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Take a photo'),
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Choose from gallery'),
            onTap: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
        ],
      ),
    ),
  );
}

class _DocumentThumbnail extends StatelessWidget {
  const _DocumentThumbnail({required this.log, required this.onTap});

  final ComplianceLog log;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final path = log.documentPath;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: path == null
            ? Icon(
                complianceTypeIcons[log.type] ?? Icons.description_outlined,
                size: 20,
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    // ignore: avoid_slow_async_io
                    File(path),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(Icons.broken_image_outlined, size: 20),
                  ),
                ],
              ),
      ),
    );
  }
}

class _AddComplianceDialog extends StatefulWidget {
  const _AddComplianceDialog();

  @override
  State<_AddComplianceDialog> createState() => _AddComplianceDialogState();
}

class _AddComplianceDialogState extends State<_AddComplianceDialog> {
  String _type = complianceTypeLabels.keys.first;
  DateTime? _expiry;
  final _costController = TextEditingController();
  XFile? _document;

  @override
  void dispose() {
    _costController.dispose();
    super.dispose();
  }

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

  Future<void> _pickDocument() async {
    final source = await _pickImageSource(context);
    if (source == null) return;
    final file = await DocumentStorageService().pick(source);
    if (file != null) setState(() => _document = file);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add compliance record'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _type,
              items: [
                for (final entry in complianceTypeLabels.entries)
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
            const SizedBox(height: 12),
            TextField(
              controller: _costController,
              decoration: const InputDecoration(labelText: 'Cost (optional)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (_document != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(_document!.path),
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDocument,
                    icon: const Icon(Icons.attach_file),
                    label: Text(_document == null ? 'Attach document (optional)' : 'Replace document'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _expiry == null
              ? null
              : () => Navigator.of(context).pop((
                    type: _type,
                    expiry: _expiry!,
                    cost: double.tryParse(_costController.text.trim()),
                    document: _document,
                  )),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
