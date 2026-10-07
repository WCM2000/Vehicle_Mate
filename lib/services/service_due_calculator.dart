class ServiceStatus {
  const ServiceStatus({required this.due, this.predictedDate});

  final bool due;
  final DateTime? predictedDate;
}

ServiceStatus evaluateServiceStatus({
  required int currentOdometerKm,
  required double avgKmPerDay,
  required DateTime now,
  int? nextDueKm,
  DateTime? nextDueDate,
}) {
  final odometerDue = nextDueKm != null && currentOdometerKm >= nextDueKm;
  final dateDue = nextDueDate != null && !now.isBefore(nextDueDate);

  if (odometerDue || dateDue) {
    return const ServiceStatus(due: true);
  }

  if (nextDueKm == null || avgKmPerDay <= 0) {
    return const ServiceStatus(due: false);
  }

  final remainingKm = nextDueKm - currentOdometerKm;
  final daysAhead = (remainingKm / avgKmPerDay).ceil();
  return ServiceStatus(
    due: false,
    predictedDate: now.add(Duration(days: daysAhead)),
  );
}
