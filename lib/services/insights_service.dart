class CostEntry {
  const CostEntry({required this.date, required this.cost});
  final DateTime date;
  final double cost;
}

class MonthlyExpense {
  const MonthlyExpense({
    required this.month,
    required this.fuel,
    required this.service,
    required this.compliance,
  });

  final DateTime month;
  final double fuel;
  final double service;
  final double compliance;

  double get total => fuel + service + compliance;
}

List<MonthlyExpense> monthlyExpenses({
  required DateTime now,
  required int monthsBack,
  required List<CostEntry> fuelCosts,
  required List<CostEntry> serviceCosts,
  required List<CostEntry> complianceCosts,
}) {
  double sumFor(List<CostEntry> items, DateTime month) => items
      .where((e) => e.date.year == month.year && e.date.month == month.month)
      .fold(0.0, (a, e) => a + e.cost);

  return List.generate(monthsBack, (i) {
    final offset = monthsBack - 1 - i;
    final month = DateTime(now.year, now.month - offset, 1);
    return MonthlyExpense(
      month: month,
      fuel: sumFor(fuelCosts, month),
      service: sumFor(serviceCosts, month),
      compliance: sumFor(complianceCosts, month),
    );
  });
}

class CostShare {
  const CostShare({
    required this.fuel,
    required this.service,
    required this.compliance,
  });

  final double fuel;
  final double service;
  final double compliance;

  double get total => fuel + service + compliance;
}

class FuelFill {
  const FuelFill({required this.date, required this.litres, this.odometerKm});
  final DateTime date;
  final double litres;
  final int? odometerKm;
}

class FuelEfficiencyPoint {
  const FuelEfficiencyPoint({required this.date, required this.kmPerLitre});
  final DateTime date;
  final double kmPerLitre;
}

List<FuelEfficiencyPoint> fuelEfficiency(List<FuelFill> fills) {
  final sorted = [...fills]..sort((a, b) => a.date.compareTo(b.date));
  final points = <FuelEfficiencyPoint>[];

  for (var i = 1; i < sorted.length; i++) {
    final prev = sorted[i - 1];
    final cur = sorted[i];
    if (prev.odometerKm == null || cur.odometerKm == null) continue;

    final deltaKm = cur.odometerKm! - prev.odometerKm!;
    if (deltaKm <= 0 || cur.litres <= 0) continue;

    points.add(
      FuelEfficiencyPoint(date: cur.date, kmPerLitre: deltaKm / cur.litres),
    );
  }
  return points;
}

class QuotaReading {
  const QuotaReading({required this.date, required this.balanceAfter});
  final DateTime date;
  final double balanceAfter;
}

class WeeklyQuotaPoint {
  const WeeklyQuotaPoint({required this.date, required this.remainingL});
  final DateTime date;
  final double remainingL;
}

List<WeeklyQuotaPoint> weeklyQuotaSeries({
  required DateTime weekStart,
  required double weeklyQuotaL,
  required List<QuotaReading> transactionsThisWeek,
}) {
  final sorted = [...transactionsThisWeek]..sort((a, b) => a.date.compareTo(b.date));
  return [
    WeeklyQuotaPoint(date: weekStart, remainingL: weeklyQuotaL),
    for (final t in sorted)
      WeeklyQuotaPoint(date: t.date, remainingL: t.balanceAfter),
  ];
}
