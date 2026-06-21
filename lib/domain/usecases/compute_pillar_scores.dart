import '../entities/habit.dart';
import '../entities/habit_log.dart';
import '../entities/pillar.dart';

/// A pillar's health on a 0–100 scale, based on how consistently its habits were
/// completed over the recent window.
class PillarScore {
  const PillarScore({
    required this.pillar,
    required this.score,
    required this.habitCount,
  });

  final PillarType pillar;

  /// 0 = nothing done in the window, 100 = every habit done every day.
  final int score;
  final int habitCount;
}

/// Pure function computing a [PillarScore] for each pillar that has active
/// habits. Surfaces "which areas am I keeping up with?" — the cross-pillar view
/// that makes ME more than a single-purpose tracker (spec §6.7.3).
class ComputePillarScores {
  const ComputePillarScores({this.windowDays = 7});

  /// Look-back window in days.
  final int windowDays;

  List<PillarScore> call({
    required List<Habit> habits,
    required List<HabitLog> recentLogs,
    required DateTime today,
  }) {
    final day = HabitLog.dateOnly(today);
    final windowStart = day.subtract(Duration(days: windowDays));

    // Distinct done-days per habit within the window (max one per day).
    final doneByHabit = <String, Set<DateTime>>{};
    for (final log in recentLogs) {
      if (log.status == HabitLogStatus.skipped) continue;
      final d = HabitLog.dateOnly(log.date);
      if (d.isBefore(windowStart) || d.isAfter(day)) continue;
      (doneByHabit[log.habitId] ??= <DateTime>{}).add(d);
    }

    final habitsByPillar = <PillarType, List<Habit>>{};
    for (final h in habits) {
      (habitsByPillar[h.pillar] ??= []).add(h);
    }

    final scores = <PillarScore>[];
    habitsByPillar.forEach((pillar, pillarHabits) {
      var hits = 0;
      for (final h in pillarHabits) {
        hits += doneByHabit[h.id]?.length ?? 0;
      }
      // Each habit can be done up to [windowDays] times.
      final denom = pillarHabits.length * windowDays;
      final rate = denom == 0 ? 0.0 : hits / denom;
      scores.add(PillarScore(
        pillar: pillar,
        score: (rate * 100).round(),
        habitCount: pillarHabits.length,
      ));
    });

    scores.sort((a, b) => a.pillar.index.compareTo(b.pillar.index));
    return scores;
  }
}
