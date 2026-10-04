import 'package:flutter/services.dart';

class ScreenBrightnessService {
  static const _channel = MethodChannel('vehicle_mate/screen_brightness');

  Future<void> setMaxBrightness() => _channel.invokeMethod('setMaxBrightness');

  Future<void> restoreBrightness() => _channel.invokeMethod('restoreBrightness');
}
