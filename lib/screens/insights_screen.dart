import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../services/insights_service.dart';
import '../services/quota_service.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(activeVehicleProvider).valueOrNull;
    final fuel = ref.watch(fuelTransactionsProvider).valueOrNull ?? const [];
    final compliance =
        ref.watch(complianceLogsProvider).valueOrNull ?? const [];
    final service = ref.watch(serviceLogsProvider).valueOrNull ?? const [];

    if (vehicle == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Insights')),
        body: const Center(child: Text('Add a vehicle first')),
      );
    }

    final now = DateTime.now();

    final monthly = monthlyExpenses(
      now: now,
      monthsBack: 4,
      fuelCosts: [
        for (final f in fuel)
          CostEntry(
            date: DateTime.fromMillisecondsSinceEpoch(f.transactionDate),
            cost: f.cost,
          ),
      ],
      serviceCosts: [
        for (final s in service)
          if (s.cost != null)
            CostEntry(
              date: DateTime.fromMillisecondsSinceEpoch(s.serviceDate),
              cost: s.cost!,
            ),
      ],
      complianceCosts: [
        for (final c in compliance)
          if (c.cost != null)
            CostEntry(
              date: DateTime.fromMillisecondsSinceEpoch(c.issuedAt ?? c.expiresAt),
              cost: c.cost!,
            ),
      ],
    );

    final costShare = CostShare(
      fuel: fuel.fold(0.0, (a, f) => a + f.cost),
      service: service.fold(0.0, (a, s) => a + (s.cost ?? 0)),
      compliance: compliance.fold(0.0, (a, c) => a + (c.cost ?? 0)),
    );

    final weekStart = QuotaService.lastWeeklyResetBoundary(now);
    final weeklyQuota = weeklyQuotaSeries(
      weekStart: weekStart,
      weeklyQuotaL: vehicle.weeklyQuotaL,
      transactionsThisWeek: [
        for (final f in fuel)
          if (!DateTime.fromMillisecondsSinceEpoch(f.transactionDate)
              .isBefore(weekStart))
            QuotaReading(
              date: DateTime.fromMillisecondsSinceEpoch(f.transactionDate),
              balanceAfter: f.balanceL,
            ),
      ],
    );

    final efficiency = fuelEfficiency([
      for (final f in fuel)
        FuelFill(
          date: DateTime.fromMillisecondsSinceEpoch(f.transactionDate),
          litres: f.litres,
          odometerKm: f.odometerKm,
        ),
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Monthly Expense'),
          SizedBox(height: 220, child: _MonthlyExpenseChart(data: monthly)),
          const SizedBox(height: 24),
          const _SectionTitle('Weekly Fuel Quota'),
          SizedBox(
            height: 200,
            child: _WeeklyQuotaChart(
              points: weeklyQuota,
              weeklyQuotaL: vehicle.weeklyQuotaL,
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('Cost Breakdown'),
          SizedBox(height: 220, child: _CostBreakdownChart(share: costShare)),
          const SizedBox(height: 24),
          const _SectionTitle('Fuel Efficiency (km/L)'),
          SizedBox(height: 200, child: _EfficiencyChart(points: efficiency)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: Theme.of(context).textTheme.titleMedium);
}

class _MonthlyExpenseChart extends StatelessWidget {
  const _MonthlyExpenseChart({required this.data});
  final List<MonthlyExpense> data;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final maxY = data
        .map((m) => m.fuel + m.service + m.compliance)
        .fold(10.0, (a, b) => b > a ? b : a);

    return BarChart(
      BarChartData(
        maxY: maxY * 1.2,
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= data.length) return const SizedBox.shrink();
                return Text(_months[data[i].month.month - 1]);
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i].total,
                  width: 22,
                  rodStackItems: [
                    BarChartRodStackItem(0, data[i].fuel, Colors.blue),
                    BarChartRodStackItem(
                      data[i].fuel,
                      data[i].fuel + data[i].service,
                      Colors.orange,
                    ),
                    BarChartRodStackItem(
                      data[i].fuel + data[i].service,
                      data[i].total,
                      Colors.purple,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _WeeklyQuotaChart extends StatelessWidget {
  const _WeeklyQuotaChart({required this.points, required this.weeklyQuotaL});
  final List<WeeklyQuotaPoint> points;
  final double weeklyQuotaL;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: weeklyQuotaL * 1.2,
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles:
              AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32)),
          bottomTitles:
              AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: false,
            color: Colors.teal,
            dotData: const FlDotData(show: true),
            spots: [
              for (var i = 0; i < points.length; i++)
                FlSpot(i.toDouble(), points[i].remainingL),
            ],
          ),
        ],
      ),
    );
  }
}

class _CostBreakdownChart extends StatelessWidget {
  const _CostBreakdownChart({required this.share});
  final CostShare share;

  @override
  Widget build(BuildContext context) {
    if (share.total <= 0) {
      return const Center(child: Text('No cost data yet'));
    }

    Widget legend(Color color, String label, double value) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 12, height: 12, color: color),
            const SizedBox(width: 6),
            Text(
              '$label ${(value / share.total * 100).toStringAsFixed(0)}%',
            ),
          ],
        );

    return Row(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  value: share.fuel,
                  color: Colors.blue,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: share.service,
                  color: Colors.orange,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: share.compliance,
                  color: Colors.purple,
                  showTitle: false,
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            legend(Colors.blue, 'Fuel', share.fuel),
            legend(Colors.orange, 'Service', share.service),
            legend(Colors.purple, 'Compliance', share.compliance),
          ],
        ),
      ],
    );
  }
}

class _EfficiencyChart extends StatelessWidget {
  const _EfficiencyChart({required this.points});
  final List<FuelEfficiencyPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const Center(
        child: Text('Record odometer readings with fuel fills to see this'),
      );
    }

    return LineChart(
      LineChartData(
        minY: 0,
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles:
              AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32)),
          bottomTitles:
              AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.green,
            dotData: const FlDotData(show: true),
            spots: [
              for (var i = 0; i < points.length; i++)
                FlSpot(i.toDouble(), points[i].kmPerLitre),
            ],
          ),
        ],
      ),
    );
  }
}
