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
  IntColumn get currentOdometerKm =>
      integer().withDefault(const Constant(0))();
  RealColumn get avgKmPerDay => real().withDefault(const Constant(30.0))();
}

class ComplianceLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  IntColumn get issuedAt => integer().nullable()();
  IntColumn get expiresAt => integer()();
  RealColumn get cost => real().nullable()();
}

class ServiceLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get description => text()();
  IntColumn get serviceDate => integer()();
  IntColumn get odometer => integer().nullable()();
  RealColumn get cost => real().nullable()();
  IntColumn get nextDueKm => integer().nullable()();
  IntColumn get nextDueDate => integer().nullable()();
}

class FuelTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  IntColumn get transactionDate => integer()();
  RealColumn get litres => real()();
  RealColumn get cost => real()();
  RealColumn get balanceL => real()();
  IntColumn get odometerKm => integer().nullable()();
}

@DriftDatabase(tables: [Vehicles, ComplianceLogs, ServiceLogs, FuelTransactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.alterTable(TableMigration(complianceLogs));
          }
          if (from < 3) {
            await m.alterTable(TableMigration(
              vehicles,
              newColumns: [vehicles.currentOdometerKm, vehicles.avgKmPerDay],
            ));
            await m.alterTable(TableMigration(
              complianceLogs,
              newColumns: [complianceLogs.cost],
            ));
            await m.alterTable(TableMigration(
              serviceLogs,
              newColumns: [
                serviceLogs.cost,
                serviceLogs.nextDueKm,
                serviceLogs.nextDueDate,
              ],
            ));
            await m.alterTable(TableMigration(
              fuelTransactions,
              newColumns: [fuelTransactions.odometerKm],
            ));
          }
        },
      );
}
