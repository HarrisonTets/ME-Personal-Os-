/// Outcome of a habit on a given day.
enum HabitLogStatus {
  done,
  partial,
  skipped;

  String get storageKey => name;

  static HabitLogStatus fromStorage(String key) =>
      HabitLogStatus.values.firstWhere((s) => s.name == key);
}

/// A single dated record of how a habit went. The source of truth for streaks,
/// completion rates and pillar scoring.
class HabitLog {
  const HabitLog({
    required this.id,
    required this.habitId,
    required this.date,
    required this.status,
    this.mood,
    this.notes,
  });

  final String id;
  final String habitId;

  /// Always normalised to local midnight (date-only). See [dateOnly].
  final DateTime date;
  final HabitLogStatus status;
  final String? mood;
  final String? notes;

  /// Strips time-of-day so logs can be compared/keyed purely by calendar day.
  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
