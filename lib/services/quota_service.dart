import 'package:drift/drift.dart';

import '../models/tables.dart';
import 'fuel_sms_parser.dart';

class QuotaService {
  QuotaService(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;

  static DateTime lastWeeklyResetBoundary(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    return today.subtract(Duration(days: today.weekday % 7));
  }

  Future<void> applyWeeklyResetIfDue() async {
    final boundary =
        lastWeeklyResetBoundary(_now()).millisecondsSinceEpoch;
    final vehicles = await _db.select(_db.vehicles).get();

    for (final vehicle in vehicles) {
      final resetAt = vehicle.quotaResetAt;
      if (resetAt != null && resetAt >= boundary) continue;

      await (_db.update(_db.vehicles)..where((t) => t.id.equals(vehicle.id)))
          .write(VehiclesCompanion(
        remainingQuotaL: Value(vehicle.weeklyQuotaL),
        quotaResetAt: Value(boundary),
      ));
    }
  }

  Future<void> recordFuelSms({
    required int vehicleId,
    required FuelSms sms,
    required DateTime receivedAt,
  }) {
    return _db.transaction(() async {
      await _db.into(_db.fuelTransactions).insert(
            FuelTransactionsCompanion.insert(
              vehicleId: vehicleId,
              transactionDate: receivedAt.millisecondsSinceEpoch,
              litres: sms.liters,
              cost: sms.cost,
              balanceL: sms.balance,
            ),
          );
      await (_db.update(_db.vehicles)..where((t) => t.id.equals(vehicleId)))
          .write(VehiclesCompanion(remainingQuotaL: Value(sms.balance)));
    });
  }
}
