import '../entities/health_log.dart';

/// Storage promise for the Health pillar.
abstract interface class HealthRepository {
  /// Records a wellness log.
  Future<void> addLog(HealthLog log);

  /// Removes a log by id (used to undo).
  Future<void> deleteLog(String id);

  /// Live list of a single day's logs, newest first.
  Stream<List<HealthLog>> watchLogsForDate(DateTime date);
}
