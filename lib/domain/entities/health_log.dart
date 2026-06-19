/// Kinds of wellness activity the user can log. Each carries its own natural
/// unit (see the presentation layer for labels/units/icons):
///   water   → glasses (each log usually = 1)
///   walk    → minutes
///   workout → minutes
///   sleep   → hours
///   stretch → minutes
enum HealthLogType {
  water,
  walk,
  workout,
  sleep,
  stretch;

  String get storageKey => name;
  static HealthLogType fromStorage(String key) =>
      HealthLogType.values.firstWhere((t) => t.name == key);
}

/// One wellness data point on a given day. [value] is in the type's natural unit
/// (glasses, minutes or hours).
class HealthLog {
  const HealthLog({
    required this.id,
    required this.type,
    required this.value,
    required this.date,
    this.note,
  });

  final String id;
  final HealthLogType type;
  final double value;

  /// Normalised to local midnight (date-only) so a day's logs group cleanly.
  final DateTime date;
  final String? note;
}
