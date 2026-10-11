import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../models/tables.dart';
import 'add_vehicle_view.dart';
import 'compliance_screen.dart';
import 'dashboard_screen.dart';
import 'fuel_tab_screen.dart';
import 'more_screen.dart';
import 'service_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> with WidgetsBindingObserver {
  int _index = 0;

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

  static const _tabs = [
    DashboardScreen(),
    ServiceScreen(),
    ComplianceScreen(),
    FuelTabScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final activeVehicle = ref.watch(activeVehicleProvider);

    return activeVehicle.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: Center(child: Text('Error: $error'))),
      data: (vehicle) {
        if (vehicle == null) {
          return AddVehicleView(onSubmit: _addVehicle);
        }
        return Scaffold(
          body: IndexedStack(index: _index, children: _tabs),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.build_outlined), selectedIcon: Icon(Icons.build), label: 'Service'),
              NavigationDestination(icon: Icon(Icons.verified_user_outlined), selectedIcon: Icon(Icons.verified_user), label: 'Compliance'),
              NavigationDestination(icon: Icon(Icons.local_gas_station_outlined), selectedIcon: Icon(Icons.local_gas_station), label: 'Fuel'),
              NavigationDestination(icon: Icon(Icons.menu_outlined), selectedIcon: Icon(Icons.menu), label: 'More'),
            ],
          ),
        );
      },
    );
  }
}
