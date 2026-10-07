import 'package:drift/drift.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../models/tables.dart';

class ComplianceAlertService {
  ComplianceAlertService(this._db);

  final AppDatabase _db;
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _alertHour = 8;
  static const _advisoryDays = 30;
  static const _badgeDays = 1;

  static const _stages = [
    _Stage(daysBefore: 14, offset: 1, high: false),
    _Stage(daysBefore: 7, offset: 2, high: true),
    _Stage(daysBefore: 1, offset: 3, high: true),
  ];

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Colombo'));

    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> scheduleFor(ComplianceLog log, String plateNumber) async {
    await cancelFor(log.id);

    final expiry = DateTime.fromMillisecondsSinceEpoch(log.expiresAt);
    final now = tz.TZDateTime.now(tz.local);

    for (final stage in _stages) {
      final scheduled = tz.TZDateTime(
        tz.local,
        expiry.year,
        expiry.month,
        expiry.day - stage.daysBefore,
        _alertHour,
      );
      if (!scheduled.isAfter(now)) continue;

      await _plugin.zonedSchedule(
        log.id * 10 + stage.offset,
        _title(stage, _label(log.type)),
        'Vehicle $plateNumber: renew before ${_formatDate(expiry)}',
        scheduled,
        NotificationDetails(
          android: AndroidNotificationDetails(
            stage.high ? 'compliance_high' : 'compliance_normal',
            stage.high ? 'Urgent compliance alerts' : 'Compliance reminders',
            importance: stage.high ? Importance.max : Importance.defaultImportance,
            priority: stage.high ? Priority.high : Priority.defaultPriority,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelFor(int complianceId) async {
    for (final stage in _stages) {
      await _plugin.cancel(complianceId * 10 + stage.offset);
    }
  }

  Future<void> refreshBadge() async {
    final cutoff = DateTime.now()
        .add(const Duration(days: _badgeDays))
        .millisecondsSinceEpoch;
    final urgent = await (_db.select(_db.complianceLogs)
          ..where((t) => t.expiresAt.isSmallerOrEqualValue(cutoff)))
        .get();

    if (urgent.isEmpty) {
      await FlutterAppBadger.removeBadge();
    } else {
      await FlutterAppBadger.updateBadgeCount(urgent.length);
    }
  }

  Future<List<ComplianceLog>> advisoryItems() {
    final cutoff = DateTime.now()
        .add(const Duration(days: _advisoryDays))
        .millisecondsSinceEpoch;
    return (_db.select(_db.complianceLogs)
          ..where((t) => t.expiresAt.isSmallerOrEqualValue(cutoff))
          ..orderBy([(t) => OrderingTerm.asc(t.expiresAt)]))
        .get();
  }

  static String _title(_Stage stage, String label) {
    if (stage.daysBefore == 1) return 'Final Notice: $label Expires Tomorrow!';
    if (stage.daysBefore == 7) return 'Urgent: $label expires in 7 days';
    return '$label expires in ${stage.daysBefore} days';
  }

  static String _label(String type) => switch (type) {
        'revenue_license' => 'Revenue License',
        'insurance' => 'Insurance',
        'emission_test' => 'Emission Test',
        _ => type,
      };

  static String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class _Stage {
  const _Stage({
    required this.daysBefore,
    required this.offset,
    required this.high,
  });

  final int daysBefore;
  final int offset;
  final bool high;
}
