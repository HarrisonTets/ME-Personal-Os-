import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/habit_log.dart';
import '../../domain/entities/suggestion.dart';
import '../providers/app_providers.dart';

/// Today's date, normalised to local midnight and fixed for the app session so
/// suggestions don't churn as the clock ticks.
final todayProvider = Provider<DateTime>(
  (ref) => HabitLog.dateOnly(DateTime.now()),
);

/// Live stream of today's habit logs. The controller depends on this so the
/// suggestion list rebuilds the instant a habit is toggled.
final todaysLogsProvider = StreamProvider.autoDispose((ref) {
  final repo = ref.watch(habitRepositoryProvider);
  return repo.watchLogsForDate(ref.watch(todayProvider));
});

/// Builds and maintains the prioritised list of suggestions shown on Today.
class TodayController extends AsyncNotifier<List<Suggestion>> {
  @override
  Future<List<Suggestion>> build() async {
    final repo = ref.watch(habitRepositoryProvider);
    final engine = ref.watch(generateTodaySuggestionsProvider);
    final today = ref.watch(todayProvider);

    // Depend on today's logs so toggling a habit re-runs the engine.
    ref.watch(todaysLogsProvider);

    final habits = await repo.getActiveHabits();
    final recentLogs =
        await repo.getLogsSince(today.subtract(const Duration(days: 7)));

    return engine(habits: habits, recentLogs: recentLogs, today: today);
  }

  /// Marks a suggestion done, or un-marks it if already done. Persistence emits
  /// on [todaysLogsProvider], which rebuilds this notifier automatically.
  Future<void> toggleDone(Suggestion suggestion) async {
    final repo = ref.read(habitRepositoryProvider);
    final today = ref.read(todayProvider);
    if (suggestion.completedToday) {
      await repo.clearLog(habitId: suggestion.habit.id, date: today);
    } else {
      await repo.setLog(
        habitId: suggestion.habit.id,
        date: today,
        status: HabitLogStatus.done,
      );
    }
  }

  /// Force a fresh run of the suggestion engine (pull-to-refresh / "regenerate").
  Future<void> regenerate() async {
    ref.invalidateSelf();
    await future;
  }
}

final todayControllerProvider =
    AsyncNotifierProvider<TodayController, List<Suggestion>>(
  TodayController.new,
);
