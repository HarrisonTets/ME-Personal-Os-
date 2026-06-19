import 'habit.dart';

/// A single recommended action surfaced on the Today screen, produced by the
/// suggestion engine. Carries the human-readable [reason] it was chosen and the
/// computed [score] used for ranking, so the UI can explain itself.
class Suggestion {
  const Suggestion({
    required this.habit,
    required this.reason,
    required this.score,
    required this.completedToday,
  });

  final Habit habit;
  final String reason;
  final double score;
  final bool completedToday;

  Suggestion copyWith({bool? completedToday}) => Suggestion(
        habit: habit,
        reason: reason,
        score: score,
        completedToday: completedToday ?? this.completedToday,
      );
}
