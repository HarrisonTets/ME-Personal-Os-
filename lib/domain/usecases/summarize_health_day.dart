import '../entities/health_log.dart';

/// A day's wellness totals, one number per activity type (in its natural unit).
class HealthSummary {
  const HealthSummary({required this.totals});

  /// type → summed value for the day. Missing types mean zero.
  final Map<HealthLogType, double> totals;

  double of(HealthLogType type) => totals[type] ?? 0;

  static const empty = HealthSummary(totals: {});
}

/// Pure function that sums a day's logs by type. No I/O, so it is easy to test.
class SummarizeHealthDay {
  const SummarizeHealthDay();

  HealthSummary call(List<HealthLog> logs) {
    if (logs.isEmpty) return HealthSummary.empty;

    final totals = <HealthLogType, double>{};
    for (final log in logs) {
      totals[log.type] = (totals[log.type] ?? 0) + log.value;
    }
    return HealthSummary(totals: totals);
  }
}
