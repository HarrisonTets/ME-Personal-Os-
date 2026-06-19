import '../entities/habit_log.dart';
import '../repositories/habit_repository.dart';

/// The set of cross-pillar trigger keys. A habit's `triggerKey` matches one of
/// these; performing the activity auto-completes that habit on Today.
///
/// Centralised here so the pillar use cases and the seed agree on the strings.
class HabitTriggers {
  const HabitTriggers._();

  static const bibleReading = 'bible_reading';
  static const financeLog = 'finance_log';
  static const focusSession = 'focus_session';
  static const healthWater = 'health_water';
  static const healthWalk = 'health_walk';
}

/// Marks every active habit whose `triggerKey` matches [triggerKey] as done for
/// [date]. Idempotent (re-running just re-sets the same done log). This is what
/// links the pillars to the Today screen.
class AutoCompleteHabits {
  const AutoCompleteHabits(this._habits);

  final HabitRepository _habits;

  Future<void> call(String triggerKey, DateTime date) async {
    final habits = await _habits.getActiveHabits();
    for (final habit in habits) {
      if (habit.triggerKey != triggerKey) continue;
      await _habits.setLog(
        habitId: habit.id,
        date: date,
        status: HabitLogStatus.done,
      );
    }
  }
}
