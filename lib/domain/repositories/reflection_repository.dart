import '../entities/reflection.dart';

/// Storage promise for daily reflections.
abstract interface class ReflectionRepository {
  /// Saves a reflection, replacing any existing one for the same day (one per
  /// day).
  Future<void> saveForDate(Reflection reflection);

  /// Today's (or a given day's) reflection, kept live; null if none yet.
  Stream<Reflection?> watchForDate(DateTime date);

  /// Recent reflections, newest first, for the history list.
  Stream<List<Reflection>> watchRecent({int limit = 30});
}
