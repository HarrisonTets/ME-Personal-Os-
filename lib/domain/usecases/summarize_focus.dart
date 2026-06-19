import '../entities/focus_session.dart';

/// A roll-up of focus sessions over a period (e.g. "today").
class FocusSummary {
  const FocusSummary({
    required this.sessionCount,
    required this.completedCount,
    required this.totalFocusedMinutes,
  });

  final int sessionCount;
  final int completedCount;
  final int totalFocusedMinutes;

  static const empty = FocusSummary(
    sessionCount: 0,
    completedCount: 0,
    totalFocusedMinutes: 0,
  );
}

/// Pure function that rolls focus sessions into a [FocusSummary]. No I/O, so it
/// is easy to unit-test.
class SummarizeFocus {
  const SummarizeFocus();

  FocusSummary call(List<FocusSession> sessions) {
    if (sessions.isEmpty) return FocusSummary.empty;

    var completed = 0;
    var minutes = 0;
    for (final s in sessions) {
      if (s.completed) completed++;
      minutes += s.focusedMinutes;
    }

    return FocusSummary(
      sessionCount: sessions.length,
      completedCount: completed,
      totalFocusedMinutes: minutes,
    );
  }
}
