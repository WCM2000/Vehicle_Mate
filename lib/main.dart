import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_theme.dart';
import 'screens/app_shell.dart';

void main() {
  runApp(const ProviderScope(child: VehicleMateApp()));
}

class VehicleMateApp extends StatelessWidget {
  const VehicleMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Mate',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const AppShell(),
    );
  }
}
