import 'reflection.dart' show Scale;

/// A weekly check-in (spec §6.1.4): how aligned the week felt, how the body
/// felt, and one thing to change next week. One per week, keyed by [weekStart].
class WeeklyReflection {
  const WeeklyReflection({
    required this.id,
    required this.weekStart,
    required this.alignment,
    required this.bodyFeel,
    required this.createdAt,
    this.oneChange,
  });

  final String id;

  /// Monday (local midnight) of the week this reflection covers.
  final DateTime weekStart;
  final Scale alignment;
  final Scale bodyFeel;

  /// "One thing you want to change next week" (optional).
  final String? oneChange;
  final DateTime createdAt;
}
