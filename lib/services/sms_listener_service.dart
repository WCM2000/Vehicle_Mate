import 'dart:io';

import 'package:another_telephony/telephony.dart';

import '../models/tables.dart';
import 'fuel_sms_parser.dart';
import 'quota_service.dart';

class FuelSmsListener {
  FuelSmsListener(this._db, this._quota);

  final AppDatabase _db;
  final QuotaService _quota;

  Future<void> start() async {
    if (!Platform.isAndroid) return;

    final telephony = Telephony.instance;
    final granted = await telephony.requestPhoneAndSmsPermissions ?? false;
    if (!granted) return;

    telephony.listenIncomingSms(
      onNewMessage: _handleMessage,
      listenInBackground: false,
    );
  }

  Future<void> _handleMessage(SmsMessage message) async {
    final sms = parseFuelSms(message.body ?? '');
    if (sms == null) return;

    final active = await (_db.select(_db.vehicles)
          ..where((t) => t.isActive.equals(true)))
        .getSingleOrNull();
    if (active == null) return;

    await _quota.recordFuelSms(
      vehicleId: active.id,
      sms: sms,
      receivedAt: DateTime.now(),
    );
  }
}
