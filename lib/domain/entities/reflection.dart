/// A three-point scale used for both mood and energy in reflections.
enum Scale {
  low,
  medium,
  high;

  String get storageKey => name;
  static Scale fromStorage(String key) =>
      Scale.values.firstWhere((s) => s.name == key);
}

/// An evening check-in for a single day (spec §6.1.4). One per day — the source
/// of self-awareness data that will later feed pillar scores and suggestion
/// weights.
class Reflection {
  const Reflection({
    required this.id,
    required this.date,
    required this.mood,
    required this.energy,
    required this.createdAt,
    this.drained,
    this.energized,
  });

  final String id;

  /// Normalised to local midnight (date-only); one reflection per day.
  final DateTime date;
  final Scale mood;
  final Scale energy;

  /// Free text: "What drained you today?"
  final String? drained;

  /// Free text: "What energized you?"
  final String? energized;

  final DateTime createdAt;
}
