import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_mate/models/tables.dart';
import 'package:vehicle_mate/services/fuel_sms_parser.dart';
import 'package:vehicle_mate/services/quota_service.dart';

void main() {
  group('parseFuelSms', () {
    test('parses a Fuel Pass message', () {
      final sms = parseFuelSms(
        'Fuel Pass: Pumped 12.5 L at Colombo, Rs. 1,250.00. Bal 30 L',
      );

      expect(sms, isNotNull);
      expect(sms!.liters, 12.5);
      expect(sms.cost, 1250.0);
      expect(sms.balance, 30.0);
    });

    test('parses a Ceypetco message with Balance keyword', () {
      final sms = parseFuelSms(
        'Ceypetco Pumped 8 L LKR 900 Balance: 12 L',
      );

      expect(sms, isNotNull);
      expect(sms!.liters, 8.0);
      expect(sms.cost, 900.0);
      expect(sms.balance, 12.0);
    });

    test('parses the Sprint 2 sample SMS', () {
      final sms = parseFuelSms(
        'Fuel Pass: Pumped 5.00L Petrol 92 at Ceypetco Kollupitiya. '
        'Amount LKR 1,850.00. Bal: 15.00L for this week.',
      );

      expect(sms, isNotNull);
      expect(sms!.liters, 5.0);
      expect(sms.cost, 1850.0);
      expect(sms.balance, 15.0);
    });

    test('ignores unrelated messages', () {
      expect(parseFuelSms('Your OTP is 123456'), isNull);
    });
  });

  group('lastWeeklyResetBoundary', () {
    test('returns the Sunday midnight that started the current week', () {
      final wednesday = DateTime(2026, 10, 7, 15, 30);
      expect(
        QuotaService.lastWeeklyResetBoundary(wednesday),
        DateTime(2026, 10, 4),
      );
    });

    test('returns the same Sunday on Sunday itself', () {
      final sunday = DateTime(2026, 10, 4, 0, 0, 1);
      expect(
        QuotaService.lastWeeklyResetBoundary(sunday),
        DateTime(2026, 10, 4),
      );
    });
  });

  group('QuotaService', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    Future<int> insertVehicle({double remaining = 5}) {
      return db.into(db.vehicles).insert(
            VehiclesCompanion.insert(
              plateNumber: 'WP-1234',
              remainingQuotaL: Value(remaining),
            ),
          );
    }

    test('resets remaining quota to weekly value when a reset is due', () async {
      final vehicleId = await insertVehicle(remaining: 5);
      final service = QuotaService(db, clock: () => DateTime(2026, 10, 7, 9));

      await service.applyWeeklyResetIfDue();

      final vehicle = await (db.select(db.vehicles)
            ..where((t) => t.id.equals(vehicleId)))
          .getSingle();
      expect(vehicle.remainingQuotaL, 20.0);
      expect(
        vehicle.quotaResetAt,
        DateTime(2026, 10, 4).millisecondsSinceEpoch,
      );
    });

    test('does not reset again within the same week', () async {
      final vehicleId = await insertVehicle(remaining: 5);
      final service = QuotaService(db, clock: () => DateTime(2026, 10, 7, 9));
      await service.applyWeeklyResetIfDue();

      await (db.update(db.vehicles)..where((t) => t.id.equals(vehicleId)))
          .write(const VehiclesCompanion(remainingQuotaL: Value(7)));
      await service.applyWeeklyResetIfDue();

      final vehicle = await (db.select(db.vehicles)
            ..where((t) => t.id.equals(vehicleId)))
          .getSingle();
      expect(vehicle.remainingQuotaL, 7.0);
    });

    test('records a fuel SMS and sets quota to the reported balance', () async {
      final vehicleId = await insertVehicle();
      final service = QuotaService(db);
      final sms = FuelSms(liters: 10, cost: 1000, balance: 10);

      await service.recordFuelSms(
        vehicleId: vehicleId,
        sms: sms,
        receivedAt: DateTime(2026, 10, 5, 8),
      );

      final transactions = await db.select(db.fuelTransactions).get();
      expect(transactions, hasLength(1));
      expect(transactions.single.litres, 10.0);
      expect(transactions.single.balanceL, 10.0);

      final vehicle = await (db.select(db.vehicles)
            ..where((t) => t.id.equals(vehicleId)))
          .getSingle();
      expect(vehicle.remainingQuotaL, 10.0);
    });
  });
}
