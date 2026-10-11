import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_mate/services/compliance_urgency.dart';

void main() {
  group('complianceUrgencyFor', () {
    test('advisory beyond 14 days', () {
      expect(complianceUrgencyFor(24), ComplianceUrgency.advisory);
    });
    test('warning at 8-14 days', () {
      expect(complianceUrgencyFor(11), ComplianceUrgency.warning);
      expect(complianceUrgencyFor(14), ComplianceUrgency.warning);
    });
    test('critical at 2-7 days', () {
      expect(complianceUrgencyFor(7), ComplianceUrgency.critical);
      expect(complianceUrgencyFor(2), ComplianceUrgency.critical);
    });
    test('final notice at 1 day or already expired', () {
      expect(complianceUrgencyFor(1), ComplianceUrgency.finalNotice);
      expect(complianceUrgencyFor(0), ComplianceUrgency.finalNotice);
      expect(complianceUrgencyFor(-3), ComplianceUrgency.finalNotice);
    });
  });
}
