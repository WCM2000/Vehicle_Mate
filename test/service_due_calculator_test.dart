import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_mate/services/service_due_calculator.dart';

void main() {
  group('evaluateServiceStatus', () {
    test('is due when odometer has reached the next due km', () {
      final status = evaluateServiceStatus(
        currentOdometerKm: 10500,
        avgKmPerDay: 30,
        now: DateTime(2026, 10, 10),
        nextDueKm: 10000,
        nextDueDate: DateTime(2026, 12, 1),
      );
      expect(status.due, isTrue);
    });

    test('is due when the due date has passed, regardless of odometer', () {
      final status = evaluateServiceStatus(
        currentOdometerKm: 5000,
        avgKmPerDay: 30,
        now: DateTime(2026, 12, 2),
        nextDueKm: 10000,
        nextDueDate: DateTime(2026, 12, 1),
      );
      expect(status.due, isTrue);
    });

    test('predicts a future date from the average daily distance', () {
      final status = evaluateServiceStatus(
        currentOdometerKm: 9000,
        avgKmPerDay: 50,
        now: DateTime(2026, 10, 10),
        nextDueKm: 10000,
        nextDueDate: DateTime(2026, 12, 1),
      );
      expect(status.due, isFalse);
      expect(status.predictedDate, DateTime(2026, 10, 30));
    });

    test('is not due with no next-due data', () {
      final status = evaluateServiceStatus(
        currentOdometerKm: 9000,
        avgKmPerDay: 30,
        now: DateTime(2026, 10, 10),
      );
      expect(status.due, isFalse);
      expect(status.predictedDate, isNull);
    });
  });
}
