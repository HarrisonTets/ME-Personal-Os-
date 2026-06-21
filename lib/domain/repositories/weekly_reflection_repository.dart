import '../entities/weekly_reflection.dart';

/// Storage promise for weekly reflections.
abstract interface class WeeklyReflectionRepository {
  /// Saves the reflection, replacing any existing one for the same week.
  Future<void> saveForWeek(WeeklyReflection reflection);

  /// The reflection for [weekStart], kept live; null if none yet.
  Stream<WeeklyReflection?> watchForWeek(DateTime weekStart);
}
