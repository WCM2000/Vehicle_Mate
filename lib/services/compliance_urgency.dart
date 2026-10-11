enum ComplianceUrgency { advisory, warning, critical, finalNotice }

/// Maps days remaining until expiry to the T-30/T-14/T-7/T-1 urgency ramp.
/// Already-expired (negative or zero days) is treated as final notice.
ComplianceUrgency complianceUrgencyFor(int daysRemaining) {
  if (daysRemaining <= 1) return ComplianceUrgency.finalNotice;
  if (daysRemaining <= 7) return ComplianceUrgency.critical;
  if (daysRemaining <= 14) return ComplianceUrgency.warning;
  return ComplianceUrgency.advisory;
}
