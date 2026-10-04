import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/tables.dart';
import '../services/compliance_alert_service.dart';
import '../services/quota_service.dart';
import '../services/sms_listener_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(
    LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      return NativeDatabase.createInBackground(
        File(p.join(dir.path, 'vehicle_mate.sqlite')),
      );
    }),
  );
  ref.onDispose(db.close);
  return db;
});

final quotaServiceProvider = Provider<QuotaService>(
  (ref) => QuotaService(ref.watch(databaseProvider)),
);

final activeVehicleProvider = StreamProvider<Vehicle?>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.vehicles)..where((t) => t.isActive.equals(true)))
      .watchSingleOrNull();
});

final complianceAlertServiceProvider = Provider<ComplianceAlertService>(
  (ref) => ComplianceAlertService(ref.watch(databaseProvider)),
);

final complianceLogsProvider = StreamProvider<List<ComplianceLog>>((ref) {
  final db = ref.watch(databaseProvider);
  final vehicle = ref.watch(activeVehicleProvider).valueOrNull;
  if (vehicle == null) return Stream.value(const []);
  return (db.select(db.complianceLogs)
        ..where((t) => t.vehicleId.equals(vehicle.id))
        ..orderBy([(t) => OrderingTerm.asc(t.expiresAt)]))
      .watch();
});

final smsListenerProvider = Provider<FuelSmsListener>(
  (ref) => FuelSmsListener(
    ref.watch(databaseProvider),
    ref.watch(quotaServiceProvider),
  ),
);
