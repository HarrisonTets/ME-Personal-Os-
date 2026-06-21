import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/habit_log.dart';
import '../../domain/entities/reflection.dart';
import '../../domain/entities/suggestion.dart';
import '../../domain/usecases/compute_pillar_scores.dart';
import '../providers/app_providers.dart';
import '../reflection/reflection_controller.dart';

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

/// The user's most recent reflected energy (defaults to medium). Drives both
/// the suggestion bias and the "day shape" banner — single source of truth.
final dayEnergyProvider = Provider.autoDispose<Scale>((ref) {
  final reflections = ref.watch(recentReflectionsProvider).value ?? const [];
  return reflections.isNotEmpty ? reflections.first.energy : Scale.medium;
});

/// Pillar health scores (0–100) for the Today balance strip. Recomputed live as
/// habits are completed.
final pillarScoresProvider =
    FutureProvider.autoDispose<List<PillarScore>>((ref) async {
  ref.watch(todaysLogsProvider); // recompute when a habit is toggled
  final repo = ref.watch(habitRepositoryProvider);
  final today = ref.watch(todayProvider);
  final habits = await repo.getActiveHabits();
  final logs = await repo.getLogsSince(today.subtract(const Duration(days: 7)));
  return const ComputePillarScores()(
    habits: habits,
    recentLogs: logs,
    today: today,
  );
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

    // Most recent reflected energy biases which difficulty of habit we surface.
    // Watching keeps Today in sync when a new reflection is saved.
    final energy = ref.watch(dayEnergyProvider);

    final habits = await repo.getActiveHabits();
    final recentLogs =
        await repo.getLogsSince(today.subtract(const Duration(days: 7)));

    return engine(
      habits: habits,
      recentLogs: recentLogs,
      today: today,
      energy: energy,
    );
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
