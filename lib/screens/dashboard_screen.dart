import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/app_theme.dart';
import '../core/compliance_types.dart';
import '../core/providers.dart';
import '../core/widgets/quota_gauge.dart';
import '../models/tables.dart';
import '../services/compliance_urgency.dart';
import '../services/insights_service.dart';
import '../services/quota_service.dart';
import '../services/service_due_calculator.dart';
import 'document_preview_screen.dart';
import 'fuel_qr_screen.dart';
import 'qr_scan_screen.dart';
import 'service_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(activeVehicleProvider).valueOrNull;
    if (vehicle == null) {
      return const Scaffold(body: Center(child: Text('Add a vehicle first')));
    }

    final compliance = ref.watch(complianceLogsProvider).valueOrNull ?? const [];
    final serviceLogs = ref.watch(serviceLogsProvider).valueOrNull ?? const [];
    final fuelTx = ref.watch(fuelTransactionsProvider).valueOrNull ?? const [];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(Icons.directions_car, color: AppColors.neonGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${vehicle.plateNumber}${vehicle.model != null ? ' • ${vehicle.model}' : ''}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(color: AppColors.neonGreen, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text('Up to date', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const _UrgencyLegend(),
          const SizedBox(height: 20),
          _ComplianceSection(records: compliance),
          const SizedBox(height: 20),
          _ServiceDueSection(vehicle: vehicle, latest: serviceLogs.isEmpty ? null : serviceLogs.first),
          const SizedBox(height: 20),
          _FuelQuotaSection(vehicle: vehicle, fuelTx: fuelTx),
        ],
      ),
    );
  }
}

class _UrgencyLegend extends StatelessWidget {
  const _UrgencyLegend();

  @override
  Widget build(BuildContext context) {
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.speed, size: 14, color: AppColors.blue),
              const SizedBox(width: 4),
              Text('Notice Ramp:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: onSurfaceVariant)),
            ],
          ),
          Wrap(
            spacing: 6,
            children: const [
              _LegendChip(label: 'T-30 Adv', color: AppColors.blue, filled: false),
              _LegendChip(label: 'T-14 Warn', color: AppColors.amber, filled: true),
              _LegendChip(label: 'T-7 Crit', color: AppColors.red, filled: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.label, required this.color, required this.filled});
  final String label;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: filled ? color.withValues(alpha: 0.18) : Colors.transparent,
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color)),
    );
  }
}

class _UrgencyStyle {
  const _UrgencyStyle({required this.color, required this.label, required this.glow});
  final Color color;
  final String label;
  final bool glow;

  static _UrgencyStyle of(ComplianceUrgency urgency) => switch (urgency) {
        ComplianceUrgency.advisory => const _UrgencyStyle(color: AppColors.blue, label: 'Advisory', glow: false),
        ComplianceUrgency.warning => const _UrgencyStyle(color: AppColors.amber, label: 'Warning', glow: false),
        ComplianceUrgency.critical => const _UrgencyStyle(color: AppColors.red, label: 'Critical', glow: true),
        ComplianceUrgency.finalNotice => const _UrgencyStyle(color: AppColors.red, label: 'Final Notice', glow: true),
      };
}

class _ComplianceSection extends StatelessWidget {
  const _ComplianceSection({required this.records});
  final List<ComplianceLog> records;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sorted = [...records]..sort((a, b) => a.expiresAt.compareTo(b.expiresAt));
    final top = sorted.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.verified_user, color: AppColors.blue, size: 20),
            const SizedBox(width: 8),
            Text('Compliance Status', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        if (top.isEmpty)
          const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No compliance records yet')))
        else
          for (final log in top) _ComplianceCard(log: log, now: now),
      ],
    );
  }
}

class _ComplianceCard extends StatelessWidget {
  const _ComplianceCard({required this.log, required this.now});
  final ComplianceLog log;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final expiry = DateTime.fromMillisecondsSinceEpoch(log.expiresAt);
    final days = expiry.difference(DateTime(now.year, now.month, now.day)).inDays;
    final urgency = complianceUrgencyFor(days);
    final style = _UrgencyStyle.of(urgency);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        shape: urgency == ComplianceUrgency.critical || urgency == ComplianceUrgency.finalNotice
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.red.withValues(alpha: 0.4)),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: log.documentPath == null
                    ? null
                    : () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DocumentPreviewScreen(
                              path: log.documentPath!,
                              title: complianceTypeLabels[log.type] ?? log.type,
                            ),
                          ),
                        ),
                child: Container(
                  width: 40,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: log.documentPath == null
                      ? Icon(complianceTypeIcons[log.type] ?? Icons.description_outlined, color: style.color, size: 20)
                      : Image.file(
                          File(log.documentPath!),
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Icon(
                            complianceTypeIcons[log.type] ?? Icons.description_outlined,
                            color: style.color,
                            size: 20,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      complianceTypeLabels[log.type] ?? log.type,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Expires ${_formatDate(expiry)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${days}d',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: style.color, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: style.color.withValues(alpha: 0.15),
                      border: Border.all(color: style.color.withValues(alpha: 0.4)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(style.label, style: TextStyle(fontSize: 10, color: style.color, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class _ServiceDueSection extends StatelessWidget {
  const _ServiceDueSection({required this.vehicle, required this.latest});
  final Vehicle vehicle;
  final ServiceLog? latest;

  @override
  Widget build(BuildContext context) {
    final status = evaluateServiceStatus(
      currentOdometerKm: vehicle.currentOdometerKm,
      avgKmPerDay: vehicle.avgKmPerDay,
      now: DateTime.now(),
      nextDueKm: latest?.nextDueKm,
      nextDueDate: latest?.nextDueDate == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(latest!.nextDueDate!),
    );

    String dueChipLabel;
    Color dueChipColor;
    if (status.due) {
      dueChipLabel = 'Due now';
      dueChipColor = AppColors.red;
    } else if (status.predictedDate != null) {
      final daysAhead = status.predictedDate!.difference(DateTime.now()).inDays;
      dueChipLabel = daysAhead >= 14
          ? 'Due in ~${(daysAhead / 7).round()} weeks'
          : 'Due in ~$daysAhead days';
      dueChipColor = AppColors.blue;
    } else {
      dueChipLabel = 'Not scheduled';
      dueChipColor = Theme.of(context).colorScheme.onSurfaceVariant;
    }

    final nextDueKm = latest?.nextDueKm;
    final remainingKm = nextDueKm == null ? null : nextDueKm - vehicle.currentOdometerKm;
    final progress = nextDueKm == null || nextDueKm <= 0
        ? 0.0
        : (vehicle.currentOdometerKm / nextDueKm).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.build, color: AppColors.neonGreen, size: 20),
                const SizedBox(width: 8),
                Text('Next Service Due', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: dueChipColor.withValues(alpha: 0.12),
                border: Border.all(color: dueChipColor.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(dueChipLabel, style: TextStyle(fontSize: 11, color: dueChipColor, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CURRENT ODOMETER', style: TextStyle(fontSize: 11, letterSpacing: 1, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              _formatKm(vehicle.currentOdometerKm),
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Text('km', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                    if (nextDueKm != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('TARGET', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                          Text('${_formatKm(nextDueKm)} km', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600)),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                if (remainingKm != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        remainingKm >= 0
                            ? 'By distance: ${_formatKm(remainingKm)} km remaining'
                            : 'By distance: ${_formatKm(-remainingKm)} km over target',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                if (status.predictedDate != null)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: AppColors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: Theme.of(context).textTheme.bodySmall,
                              children: [
                                const TextSpan(text: 'By date: predicted '),
                                TextSpan(
                                  text: _formatDate(status.predictedDate!),
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.calendar_month, size: 18),
                        label: const Text('Book Service'),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ServiceScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.edit_note, size: 18),
                        label: const Text('Log Maintenance'),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ServiceScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _formatKm(int km) {
    final negative = km < 0;
    final s = km.abs().toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return negative ? '-$buf' : buf.toString();
  }

  static String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class _FuelQuotaSection extends ConsumerWidget {
  const _FuelQuotaSection({required this.vehicle, required this.fuelTx});
  final Vehicle vehicle;
  final List<FuelTransaction> fuelTx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consumed = vehicle.weeklyQuotaL - vehicle.remainingQuotaL;
    final percentRemaining = vehicle.weeklyQuotaL <= 0
        ? 0
        : (vehicle.remainingQuotaL / vehicle.weeklyQuotaL * 100).round();

    final nextReset = QuotaService.lastWeeklyResetBoundary(DateTime.now())
        .add(const Duration(days: 7));
    final untilReset = nextReset.difference(DateTime.now());
    final resetLabel = untilReset.isNegative
        ? 'Resets shortly'
        : 'Resets Sunday midnight (in ${untilReset.inDays}d ${untilReset.inHours % 24}h)';

    final efficiency = fuelEfficiency([
      for (final f in fuelTx)
        FuelFill(
          date: DateTime.fromMillisecondsSinceEpoch(f.transactionDate),
          litres: f.litres,
          odometerKm: f.odometerKm,
        ),
    ]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.local_gas_station, color: AppColors.neonGreen, size: 20),
                const SizedBox(width: 8),
                Text('National Fuel Pass Quota', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.neonGreen.withValues(alpha: 0.15),
                border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('WEEKLY CYCLE', style: TextStyle(fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QuotaGauge(remaining: vehicle.remainingQuotaL, weekly: vehicle.weeklyQuotaL),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHigh.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                _StatRow(label: 'Allocated', value: '${vehicle.weeklyQuotaL.toStringAsFixed(1)} L'),
                                const SizedBox(height: 4),
                                _StatRow(label: 'Consumed this week', value: '${consumed.toStringAsFixed(1)} L', valueColor: AppColors.blue),
                                const Divider(height: 14),
                                _StatRow(label: 'Quota Remaining', value: '$percentRemaining%', labelColor: AppColors.neonGreen, valueColor: AppColors.neonGreen),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(resetLabel, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _openQr(context, ref),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.neonGreen),
                          ),
                          child: Icon(Icons.qr_code_2, color: Colors.black, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.fuelPassQr == null ? 'Scan Fuel Pass QR' : 'Show QR for Pumper',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(
                                vehicle.fuelPassQr == null ? 'Not linked yet' : 'Tap to open offline',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        FilledButton.tonal(
                          onPressed: () => _openQr(context, ref),
                          child: const Text('Open'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (efficiency.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.trending_up, color: AppColors.neonGreen, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: Theme.of(context).textTheme.bodySmall,
                              children: [
                                TextSpan(
                                  text: '${efficiency.last.kmPerLitre.toStringAsFixed(1)} km/L  ',
                                  style: const TextStyle(color: AppColors.neonGreen, fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(text: 'latest efficiency'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openQr(BuildContext context, WidgetRef ref) async {
    if (vehicle.fuelPassQr != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => FuelQrScreen(data: vehicle.fuelPassQr!)),
      );
      return;
    }
    final qr = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const QrScanScreen()),
    );
    if (qr != null) {
      final db = ref.read(databaseProvider);
      await (db.update(db.vehicles)..where((t) => t.id.equals(vehicle.id)))
          .write(VehiclesCompanion(fuelPassQr: Value(qr)));
    }
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value, this.labelColor, this.valueColor});
  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: labelColor ?? Theme.of(context).colorScheme.onSurfaceVariant)),
        Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: valueColor)),
      ],
    );
  }
}
