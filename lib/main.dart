import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/fuel_wallet_screen.dart';

void main() {
  runApp(const ProviderScope(child: VehicleMateApp()));
}

class VehicleMateApp extends StatelessWidget {
  const VehicleMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Mate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FuelWalletScreen(),
    );
  }
}
