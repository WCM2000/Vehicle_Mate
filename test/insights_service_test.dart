import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_mate/services/insights_service.dart';

void main() {
  group('monthlyExpenses', () {
    test('buckets costs by month across categories', () {
      final result = monthlyExpenses(
        now: DateTime(2026, 4, 15),
        monthsBack: 4,
        fuelCosts: [
          CostEntry(date: DateTime(2026, 1, 10), cost: 10000),
          CostEntry(date: DateTime(2026, 4, 2), cost: 30000),
        ],
        serviceCosts: [
          CostEntry(date: DateTime(2026, 2, 5), cost: 40000),
        ],
        complianceCosts: [
          CostEntry(date: DateTime(2026, 4, 1), cost: 20000),
        ],
      );

      expect(result, hasLength(4));
      expect(result.map((m) => m.month.month), [1, 2, 3, 4]);
      expect(result[0].fuel, 10000);
      expect(result[1].service, 40000);
      expect(result[2].total, 0);
      expect(result[3].fuel, 30000);
      expect(result[3].compliance, 20000);
    });
  });

  group('fuelEfficiency', () {
    test('computes km/L between consecutive fills with odometer readings', () {
      final points = fuelEfficiency([
        FuelFill(date: DateTime(2026, 1, 1), litres: 10, odometerKm: 1000),
        FuelFill(date: DateTime(2026, 1, 8), litres: 10, odometerKm: 1127),
        FuelFill(date: DateTime(2026, 1, 15), litres: 12, odometerKm: null),
      ]);

      expect(points, hasLength(1));
      expect(points.single.kmPerLitre, 12.7);
    });

    test('ignores fills without odometer readings', () {
      final points = fuelEfficiency([
        FuelFill(date: DateTime(2026, 1, 1), litres: 10),
        FuelFill(date: DateTime(2026, 1, 8), litres: 10),
      ]);
      expect(points, isEmpty);
    });
  });

  group('weeklyQuotaSeries', () {
    test('starts at the weekly quota and follows transaction balances', () {
      final series = weeklyQuotaSeries(
        weekStart: DateTime(2026, 10, 4),
        weeklyQuotaL: 20,
        transactionsThisWeek: [
          QuotaReading(date: DateTime(2026, 10, 6), balanceAfter: 15),
          QuotaReading(date: DateTime(2026, 10, 9), balanceAfter: 5),
        ],
      );

      expect(series, hasLength(3));
      expect(series[0].remainingL, 20);
      expect(series[1].remainingL, 15);
      expect(series[2].remainingL, 5);
    });
  });
}
