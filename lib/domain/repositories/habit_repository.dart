import '../entities/habit.dart';
import '../entities/habit_log.dart';
import '../entities/pillar.dart';

/// Abstraction over habit + habit-log persistence. The domain depends only on
/// this interface; the concrete Drift implementation lives in the data layer,
/// keeping business logic free of storage details (and swappable for sync).
abstract interface class HabitRepository {
  /// All habits with [Habit.active] == true.
  Future<List<Habit>> getActiveHabits();

  /// Enables habits belonging to [enabledPillars] and disables the rest. Used by
  /// onboarding to focus the app on the pillars the user picked.
  Future<void> setHabitsActiveForPillars(Set<PillarType> enabledPillars);

  /// Logs on or after [from] (inclusive). Used to compute streaks and
  /// completion rates for the suggestion engine.
  Future<List<HabitLog>> getLogsSince(DateTime from);

  /// Marks [habitId] with [status] on [date]. Replaces any existing log for
  /// that habit/day so toggling is idempotent.
  Future<void> setLog({
    required String habitId,
    required DateTime date,
    required HabitLogStatus status,
  });

  /// Removes the log for [habitId] on [date], if any (used to "un-complete").
  Future<void> clearLog({required String habitId, required DateTime date});

  /// Emits today's logs whenever they change, so the UI can react live.
  Stream<List<HabitLog>> watchLogsForDate(DateTime date);
}
