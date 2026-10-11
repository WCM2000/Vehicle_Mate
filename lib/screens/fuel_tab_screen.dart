import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../core/widgets/quota_gauge.dart';
import '../models/tables.dart';
import 'fuel_qr_screen.dart';
import 'qr_scan_screen.dart';

class FuelTabScreen extends ConsumerWidget {
  const FuelTabScreen({super.key});

  Future<void> _saveFuelPassQr(WidgetRef ref, Vehicle vehicle, String qr) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.vehicles)..where((t) => t.id.equals(vehicle.id)))
        .write(VehiclesCompanion(fuelPassQr: Value(qr)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(activeVehicleProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Fuel Pass')),
      body: vehicle == null
          ? const Center(child: Text('Add a vehicle first'))
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QuotaGauge(
                      remaining: vehicle.remainingQuotaL,
                      weekly: vehicle.weeklyQuotaL,
                      size: 180,
                      strokeWidth: 14,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Resets every Sunday midnight',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 32),
                    FilledButton.icon(
                      icon: Icon(
                        vehicle.fuelPassQr == null
                            ? Icons.qr_code_scanner
                            : Icons.qr_code,
                      ),
                      label: Text(
                        vehicle.fuelPassQr == null
                            ? 'Scan Fuel Pass QR'
                            : 'Show Fuel QR',
                      ),
                      onPressed: () async {
                        if (vehicle.fuelPassQr != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  FuelQrScreen(data: vehicle.fuelPassQr!),
                            ),
                          );
                          return;
                        }
                        final qr = await Navigator.of(context).push<String>(
                          MaterialPageRoute(
                            builder: (_) => const QrScanScreen(),
                          ),
                        );
                        if (qr != null) await _saveFuelPassQr(ref, vehicle, qr);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
