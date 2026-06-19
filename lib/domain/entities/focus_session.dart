/// A single deep-work session the user ran. Stored once it ends (whether it ran
/// to completion or was stopped early).
///
/// The live countdown itself is presentation state; this entity is just the
/// recorded result used for history and daily totals.
class FocusSession {
  const FocusSession({
    required this.id,
    required this.intention,
    required this.plannedMinutes,
    required this.focusedMinutes,
    required this.completed,
    required this.startedAt,
  });

  final String id;

  /// What the user set out to do, e.g. "Ship the login screen".
  final String intention;

  /// The duration the user picked (e.g. 25).
  final int plannedMinutes;

  /// Minutes actually focused — equals [plannedMinutes] when the session ran to
  /// the end, or the elapsed time if stopped early.
  final int focusedMinutes;

  /// True if the timer reached zero; false if the user ended it early.
  final bool completed;

  final DateTime startedAt;
}
