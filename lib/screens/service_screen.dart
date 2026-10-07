import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../models/tables.dart';
import '../services/service_due_calculator.dart';

class ServiceScreen extends ConsumerWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(activeVehicleProvider).valueOrNull;
    final logs = ref.watch(serviceLogsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Service Records')),
      floatingActionButton: vehicle == null
          ? null
          : FloatingActionButton(
              onPressed: () => _showAddDialog(context, ref, vehicle),
              child: const Icon(Icons.add),
            ),
      body: vehicle == null
          ? const Center(child: Text('Add a vehicle first'))
          : logs.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (items) {
                final latest = items.isEmpty ? null : items.first;
                final status = evaluateServiceStatus(
                  currentOdometerKm: vehicle.currentOdometerKm,
                  avgKmPerDay: vehicle.avgKmPerDay,
                  now: DateTime.now(),
                  nextDueKm: latest?.nextDueKm,
                  nextDueDate: latest?.nextDueDate == null
                      ? null
                      : DateTime.fromMillisecondsSinceEpoch(
                          latest!.nextDueDate!),
                );

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _StatusCard(
                      vehicle: vehicle,
                      status: status,
                      hasNextDue: latest?.nextDueKm != null ||
                          latest?.nextDueDate != null,
                    ),
                    const SizedBox(height: 16),
                    if (items.isEmpty)
                      const Text('No service records yet')
                    else
                      for (final log in items) _ServiceTile(log: log),
                  ],
                );
              },
            ),
    );
  }

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    Vehicle vehicle,
  ) async {
    final result = await showDialog<_ServiceFormResult>(
      context: context,
      builder: (_) => const _AddServiceDialog(),
    );
    if (result == null) return;

    final db = ref.read(databaseProvider);
    final previous = await (db.select(db.serviceLogs)
          ..where((t) => t.vehicleId.equals(vehicle.id))
          ..orderBy([(t) => OrderingTerm.desc(t.serviceDate)])
          ..limit(1))
        .getSingleOrNull();

    await db.into(db.serviceLogs).insert(
          ServiceLogsCompanion.insert(
            vehicleId: vehicle.id,
            description: result.description,
            serviceDate: result.serviceDate.millisecondsSinceEpoch,
            odometer: Value(result.odometerKm),
            cost: Value(result.cost),
            nextDueKm: Value(result.nextDueKm),
            nextDueDate: Value(result.nextDueDate?.millisecondsSinceEpoch),
          ),
        );

    var avgKmPerDay = vehicle.avgKmPerDay;
    if (previous != null && previous.odometer != null) {
      final deltaKm = result.odometerKm - previous.odometer!;
      final deltaDays = result.serviceDate
          .difference(DateTime.fromMillisecondsSinceEpoch(previous.serviceDate))
          .inDays;
      if (deltaKm > 0 && deltaDays > 0) {
        avgKmPerDay = deltaKm / deltaDays;
      }
    }

    await (db.update(db.vehicles)..where((t) => t.id.equals(vehicle.id)))
        .write(
      VehiclesCompanion(
        currentOdometerKm: Value(
          result.odometerKm > vehicle.currentOdometerKm
              ? result.odometerKm
              : vehicle.currentOdometerKm,
        ),
        avgKmPerDay: Value(avgKmPerDay),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.vehicle,
    required this.status,
    required this.hasNextDue,
  });

  final Vehicle vehicle;
  final ServiceStatus status;
  final bool hasNextDue;

  @override
  Widget build(BuildContext context) {
    final String message;
    final Color color;
    if (!hasNextDue) {
      message = 'No upcoming service scheduled';
      color = Theme.of(context).colorScheme.surfaceContainerHighest;
    } else if (status.due) {
      message = 'Service is due now';
      color = Theme.of(context).colorScheme.errorContainer;
    } else {
      message =
          'Predicted next service: ${_formatDate(status.predictedDate!)}';
      color = Theme.of(context).colorScheme.primaryContainer;
    }

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Odometer: ${vehicle.currentOdometerKm} km',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('Avg: ${vehicle.avgKmPerDay.toStringAsFixed(1)} km/day'),
            const SizedBox(height: 8),
            Text(message),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.log});

  final ServiceLog log;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(log.serviceDate);
    return ListTile(
      title: Text(log.description),
      subtitle: Text(
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
        '${log.odometer != null ? ' · ${log.odometer} km' : ''}'
        '${log.cost != null ? ' · Rs. ${log.cost!.toStringAsFixed(0)}' : ''}',
      ),
    );
  }
}

class _ServiceFormResult {
  const _ServiceFormResult({
    required this.description,
    required this.serviceDate,
    required this.odometerKm,
    this.cost,
    this.nextDueKm,
    this.nextDueDate,
  });

  final String description;
  final DateTime serviceDate;
  final int odometerKm;
  final double? cost;
  final int? nextDueKm;
  final DateTime? nextDueDate;
}

class _AddServiceDialog extends StatefulWidget {
  const _AddServiceDialog();

  @override
  State<_AddServiceDialog> createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<_AddServiceDialog> {
  final _descriptionController = TextEditingController();
  final _odometerController = TextEditingController();
  final _costController = TextEditingController();
  final _nextDueKmController = TextEditingController();
  DateTime _serviceDate = DateTime.now();
  DateTime? _nextDueDate;

  @override
  void dispose() {
    _descriptionController.dispose();
    _odometerController.dispose();
    _costController.dispose();
    _nextDueKmController.dispose();
    super.dispose();
  }

  Future<void> _pickServiceDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _serviceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _serviceDate = picked);
  }

  Future<void> _pickNextDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextDueDate ?? now.add(const Duration(days: 90)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _nextDueDate = picked);
  }

  void _submit() {
    final description = _descriptionController.text.trim();
    final odometer = int.tryParse(_odometerController.text.trim());
    if (description.isEmpty || odometer == null) return;

    Navigator.of(context).pop(
      _ServiceFormResult(
        description: description,
        serviceDate: _serviceDate,
        odometerKm: odometer,
        cost: double.tryParse(_costController.text.trim()),
        nextDueKm: int.tryParse(_nextDueKmController.text.trim()),
        nextDueDate: _nextDueDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add service record'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _odometerController,
              decoration: const InputDecoration(labelText: 'Odometer (km)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _costController,
              decoration: const InputDecoration(labelText: 'Cost (optional)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _nextDueKmController,
              decoration:
                  const InputDecoration(labelText: 'Next due km (optional)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _pickServiceDate,
              child: Text('Service date: ${_dateLabel(_serviceDate)}'),
            ),
            OutlinedButton(
              onPressed: _pickNextDueDate,
              child: Text(
                _nextDueDate == null
                    ? 'Pick next due date (optional)'
                    : 'Next due: ${_dateLabel(_nextDueDate!)}',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }

  static String _dateLabel(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
