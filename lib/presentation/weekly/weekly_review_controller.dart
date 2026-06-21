import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/habit_log.dart';
import '../../domain/entities/weekly_reflection.dart';
import '../../domain/usecases/compute_pillar_scores.dart';
import '../finance/finance_controller.dart' show weekStartProvider;
import '../providers/app_providers.dart';
import '../today/today_controller.dart' show pillarScoresProvider;

/// This week's weekly reflection (null until written), kept live.
final currentWeekReflectionProvider =
    StreamProvider.autoDispose<WeeklyReflection?>((ref) {
  final weekStart = ref.watch(weekStartProvider);
  return ref.watch(weeklyReflectionRepositoryProvider).watchForWeek(weekStart);
});

/// A cross-pillar roll-up of the current week — the payoff view that ties every
/// pillar together in one place (spec §8.2 Weekly Review).
class WeeklySummary {
  const WeeklySummary({
    required this.weekStart,
    required this.habitsCompleted,
    required this.focusMinutes,
    required this.spent,
    required this.bibleReadings,
    required this.pillarScores,
  });

  final DateTime weekStart;
  final int habitsCompleted;
  final int focusMinutes;
  final double spent;
  final int bibleReadings;
  final List<PillarScore> pillarScores;
}

/// Aggregates this week's activity from every pillar's repository. Each source is
/// read once (`.first` for the streams) and combined into a [WeeklySummary].
final weeklyReviewProvider =
    FutureProvider.autoDispose<WeeklySummary>((ref) async {
  final weekStart = ref.watch(weekStartProvider);

  // Habits completed this week.
  final habitRepo = ref.watch(habitRepositoryProvider);
  final logs = await habitRepo.getLogsSince(weekStart);
  final habitsCompleted =
      logs.where((l) => l.status == HabitLogStatus.done).length;

  // Pillar balance (reuses the Today strip's computation).
  final pillarScores = await ref.watch(pillarScoresProvider.future);

  // Focus minutes this week.
  final sessions =
      await ref.watch(focusRepositoryProvider).watchSessionsSince(weekStart).first;
  final focus = ref.watch(summarizeFocusProvider)(sessions);

  // Money spent this week.
  final entries =
      await ref.watch(financeRepositoryProvider).watchEntriesSince(weekStart).first;
  final spending = ref.watch(summarizeSpendingProvider)(entries);

  // Bible readings completed this week.
  var bibleReadings = 0;
  final plan = await ref.watch(spiritualRepositoryProvider).getActivePlan();
  if (plan != null) {
    final assignments = await ref
        .watch(spiritualRepositoryProvider)
        .watchAssignments(plan.id)
        .first;
    bibleReadings = assignments
        .where((a) =>
            a.completedAt != null && !a.completedAt!.isBefore(weekStart))
        .length;
  }

  return WeeklySummary(
    weekStart: weekStart,
    habitsCompleted: habitsCompleted,
    focusMinutes: focus.totalFocusedMinutes,
    spent: spending.totalExpense,
    bibleReadings: bibleReadings,
    pillarScores: pillarScores,
  );
});
