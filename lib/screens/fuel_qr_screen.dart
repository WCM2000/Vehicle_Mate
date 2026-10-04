import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../services/screen_brightness_service.dart';

class FuelQrScreen extends StatefulWidget {
  const FuelQrScreen({super.key, required this.data});

  final String data;

  @override
  State<FuelQrScreen> createState() => _FuelQrScreenState();
}

class _FuelQrScreenState extends State<FuelQrScreen> {
  final _brightness = ScreenBrightnessService();

  @override
  void initState() {
    super.initState();
    _brightness.setMaxBrightness();
  }

  @override
  void dispose() {
    _brightness.restoreBrightness();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel Pass QR')),
      body: Center(
        child: QrImageView(
          data: widget.data,
          size: 280,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
