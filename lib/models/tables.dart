import 'package:drift/drift.dart';

part 'tables.g.dart';

class Vehicles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get plateNumber => text().withLength(min: 1, max: 20).unique()();
  TextColumn get make => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get fuelPassQr => text().nullable()();
  RealColumn get weeklyQuotaL => real().withDefault(const Constant(20.0))();
  RealColumn get remainingQuotaL => real().withDefault(const Constant(20.0))();
  IntColumn get quotaResetAt => integer().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
}

class ComplianceLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  IntColumn get issuedAt => integer().nullable()();
  IntColumn get expiresAt => integer()();
}

class ServiceLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get description => text()();
  IntColumn get serviceDate => integer()();
  IntColumn get odometer => integer().nullable()();
}

class FuelTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  IntColumn get transactionDate => integer()();
  RealColumn get litres => real()();
  RealColumn get cost => real()();
  RealColumn get balanceL => real()();
}

@DriftDatabase(tables: [Vehicles, ComplianceLogs, ServiceLogs, FuelTransactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.alterTable(TableMigration(complianceLogs));
          }
        },
      );
}
