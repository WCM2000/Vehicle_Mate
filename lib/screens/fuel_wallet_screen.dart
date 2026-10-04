import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../models/tables.dart';
import 'compliance_screen.dart';
import 'fuel_qr_screen.dart';
import 'qr_scan_screen.dart';

class FuelWalletScreen extends ConsumerStatefulWidget {
  const FuelWalletScreen({super.key});

  @override
  ConsumerState<FuelWalletScreen> createState() => _FuelWalletScreenState();
}

class _FuelWalletScreenState extends ConsumerState<FuelWalletScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onResumed());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _onResumed();
  }

  Future<void> _onResumed() async {
    await ref.read(quotaServiceProvider).applyWeeklyResetIfDue();
    await ref.read(smsListenerProvider).start();
    final alerts = ref.read(complianceAlertServiceProvider);
    await alerts.init();
    await alerts.refreshBadge();
  }

  Future<void> _addVehicle({
    required String plateNumber,
    String? model,
    required double weeklyQuota,
  }) async {
    final db = ref.read(databaseProvider);
    await db.transaction(() async {
      await db
          .update(db.vehicles)
          .write(const VehiclesCompanion(isActive: Value(false)));
      await db.into(db.vehicles).insert(
            VehiclesCompanion.insert(
              plateNumber: plateNumber,
              model: Value(model),
              weeklyQuotaL: Value(weeklyQuota),
              remainingQuotaL: Value(weeklyQuota),
              isActive: const Value(true),
            ),
          );
    });
    await ref.read(quotaServiceProvider).applyWeeklyResetIfDue();
  }

  Future<void> _saveFuelPassQr(Vehicle vehicle, String qr) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.vehicles)..where((t) => t.id.equals(vehicle.id)))
        .write(VehiclesCompanion(fuelPassQr: Value(qr)));
  }

  @override
  Widget build(BuildContext context) {
    final activeVehicle = ref.watch(activeVehicleProvider);
    final compliance = ref.watch(complianceLogsProvider).valueOrNull ?? const [];
    final advisoryCutoff = DateTime.now()
        .add(const Duration(days: 30))
        .millisecondsSinceEpoch;
    final advisories = compliance
        .where((log) => log.expiresAt <= advisoryCutoff)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_outlined),
            tooltip: 'Compliance records',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ComplianceScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (advisories.isNotEmpty)
            MaterialBanner(
              content: Text(
                '${advisories.length} compliance item(s) expire within 30 days',
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              actions: const [SizedBox.shrink()],
            ),
          Expanded(
            child: activeVehicle.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (vehicle) => vehicle == null
                  ? _AddVehicleView(onSubmit: _addVehicle)
                  : _WalletView(
                      vehicle: vehicle,
                      onScanQr: () async {
                        final qr = await Navigator.of(context).push<String>(
                          MaterialPageRoute(
                            builder: (_) => const QrScanScreen(),
                          ),
                        );
                        if (qr != null) await _saveFuelPassQr(vehicle, qr);
                      },
                      onShowQr: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              FuelQrScreen(data: vehicle.fuelPassQr!),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef _AddVehicleSubmit = Future<void> Function({
  required String plateNumber,
  String? model,
  required double weeklyQuota,
});

class _AddVehicleView extends StatefulWidget {
  const _AddVehicleView({required this.onSubmit});

  final _AddVehicleSubmit onSubmit;

  @override
  State<_AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<_AddVehicleView> {
  final _plateController = TextEditingController();
  final _modelController = TextEditingController();
  final _quotaController = TextEditingController(text: '20.0');

  @override
  void dispose() {
    _plateController.dispose();
    _modelController.dispose();
    _quotaController.dispose();
    super.dispose();
  }

  void _submit() {
    final plate = _plateController.text.trim();
    final quota = double.tryParse(_quotaController.text.trim());
    if (plate.isEmpty || quota == null || quota <= 0) return;

    final model = _modelController.text.trim();
    widget.onSubmit(
      plateNumber: plate,
      model: model.isEmpty ? null : model,
      weeklyQuota: quota,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          TextField(
            controller: _plateController,
            decoration: const InputDecoration(labelText: 'Plate number'),
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _modelController,
            decoration: const InputDecoration(labelText: 'Vehicle model'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _quotaController,
            decoration: const InputDecoration(
              labelText: 'Initial weekly quota (L)',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _submit,
            child: const Text('Save vehicle'),
          ),
        ],
        ),
      ),
    );
  }
}

class _WalletView extends StatelessWidget {
  const _WalletView({
    required this.vehicle,
    required this.onScanQr,
    required this.onShowQr,
  });

  final Vehicle vehicle;
  final VoidCallback onScanQr;
  final VoidCallback onShowQr;

  @override
  Widget build(BuildContext context) {
    final hasQr = vehicle.fuelPassQr != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              vehicle.plateNumber,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (vehicle.model != null) Text(vehicle.model!),
            const SizedBox(height: 24),
            QuotaRing(
              remaining: vehicle.remainingQuotaL,
              weekly: vehicle.weeklyQuotaL,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: hasQr ? onShowQr : onScanQr,
              child: Text(hasQr ? 'Show Fuel QR' : 'Scan Fuel Pass QR'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuotaRing extends StatelessWidget {
  const QuotaRing({super.key, required this.remaining, required this.weekly});

  final double remaining;
  final double weekly;

  @override
  Widget build(BuildContext context) {
    final fraction = weekly <= 0 ? 0.0 : (remaining / weekly).clamp(0.0, 1.0);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: fraction,
              strokeWidth: 14,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${remaining.toStringAsFixed(1)} L',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'of ${weekly.toStringAsFixed(1)} L',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
