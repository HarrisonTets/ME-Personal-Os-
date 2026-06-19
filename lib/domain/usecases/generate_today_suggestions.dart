import 'dart:math' as math;

import '../entities/habit.dart';
import '../entities/habit_log.dart';
import '../entities/pillar.dart';
import '../entities/suggestion.dart';

/// Rule-based engine that turns the user's habits + recent history into a small,
/// prioritised set of actions for today. This is deliberately pure (no I/O, no
/// Flutter) so it is trivially testable and can later be swapped for smarter
/// logic without touching the rest of the app.
///
/// Ranking intuition (see spec §6.1.2 / §6.7.3):
///   * weaker pillars (low recent completion) are prioritised,
///   * live streaks are protected (don't let them break),
///   * habits not done in a while resurface,
///   * lighter habits break ties to help the user build momentum,
///   * the daily budget caps how many we surface, with pillar diversity so a
///     single pillar can't crowd out the rest.
class GenerateTodaySuggestions {
  const GenerateTodaySuggestions({
    this.dailyBudget = 5,
    this.maxPerPillar = 2,
    this.historyWindowDays = 7,
  });

  /// Maximum number of *outstanding* (not-yet-done) actions to surface.
  final int dailyBudget;

  /// Caps how many suggestions a single pillar may contribute, preserving
  /// cross-pillar balance.
  final int maxPerPillar;

  /// Look-back window used for completion-rate and recency signals.
  final int historyWindowDays;

  /// [today] is injected (rather than read from the clock) so the engine stays
  /// pure and deterministic under test.
  List<Suggestion> call({
    required List<Habit> habits,
    required List<HabitLog> recentLogs,
    required DateTime today,
  }) {
    final day = HabitLog.dateOnly(today);
    final windowStart = day.subtract(Duration(days: historyWindowDays));

    // Index "done/partial" logs by habit and by pillar for fast lookups.
    final doneDatesByHabit = <String, Set<DateTime>>{};
    final pillarHits = {for (final p in PillarType.values) p: 0};
    for (final log in recentLogs) {
      if (log.status == HabitLogStatus.skipped) continue;
      final d = HabitLog.dateOnly(log.date);
      if (d.isBefore(windowStart) || d.isAfter(day)) continue;
      (doneDatesByHabit[log.habitId] ??= <DateTime>{}).add(d);
    }
    for (final habit in habits) {
      final hits = doneDatesByHabit[habit.id]?.length ?? 0;
      pillarHits[habit.pillar] = (pillarHits[habit.pillar] ?? 0) + hits;
    }

    // Completion rate per pillar over the window (0..1). Used so weaker pillars
    // float to the top. Denominator = (#habits in pillar) * window days.
    final habitsPerPillar = <PillarType, int>{};
    for (final h in habits) {
      habitsPerPillar[h.pillar] = (habitsPerPillar[h.pillar] ?? 0) + 1;
    }
    double pillarCompletionRate(PillarType p) {
      final denom = (habitsPerPillar[p] ?? 0) * historyWindowDays;
      if (denom == 0) return 0;
      return (pillarHits[p] ?? 0) / denom;
    }

    final scored = <Suggestion>[];
    for (final habit in habits) {
      final doneDates = doneDatesByHabit[habit.id] ?? const <DateTime>{};
      final completedToday = doneDates.contains(day);
      final streak = _currentStreak(doneDates, day);
      final daysSinceDone = _daysSinceLastDone(doneDates, day);

      // --- scoring ---------------------------------------------------------
      // Weaker pillar → bigger boost (up to 100).
      final pillarWeakness = (1 - pillarCompletionRate(habit.pillar)) * 100;

      // Protect a live streak that hasn't been continued today yet.
      final streakBoost =
          (!completedToday && streak > 0) ? math.min(streak, 10) * 4.0 : 0.0;

      // Resurface habits that have been neglected (capped at window length).
      final recencyBoost =
          math.min(daysSinceDone, historyWindowDays) * 3.0;

      // Light habits get a small nudge to help build momentum.
      final difficultyNudge = switch (habit.difficulty) {
        HabitDifficulty.light => 6.0,
        HabitDifficulty.medium => 3.0,
        HabitDifficulty.deep => 0.0,
      };

      final score =
          pillarWeakness + streakBoost + recencyBoost + difficultyNudge;

      scored.add(Suggestion(
        habit: habit,
        reason: _reasonFor(
          completedToday: completedToday,
          streak: streak,
          daysSinceDone: daysSinceDone,
          pillarWeakness: pillarWeakness,
        ),
        score: score,
        completedToday: completedToday,
      ));
    }

    // Already-done items always stay visible (so the user sees progress) but
    // don't consume the budget. Outstanding items are budget- and
    // diversity-limited.
    final done = scored.where((s) => s.completedToday).toList()
      ..sort((a, b) => a.habit.pillar.index.compareTo(b.habit.pillar.index));

    final outstanding = scored.where((s) => !s.completedToday).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    final picked = <Suggestion>[];
    final perPillar = <PillarType, int>{};
    for (final s in outstanding) {
      if (picked.length >= dailyBudget) break;
      final count = perPillar[s.habit.pillar] ?? 0;
      if (count >= maxPerPillar) continue;
      perPillar[s.habit.pillar] = count + 1;
      picked.add(s);
    }

    return [...picked, ...done];
  }

  /// Counts consecutive done-days ending at [day] (inclusive if done today,
  /// otherwise the run ending yesterday — that's the streak still worth saving).
  int _currentStreak(Set<DateTime> doneDates, DateTime day) {
    if (doneDates.isEmpty) return 0;
    var cursor = doneDates.contains(day) ? day : day.subtract(const Duration(days: 1));
    var streak = 0;
    while (doneDates.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Whole days since the habit was last done. [historyWindowDays] + 1 means
  /// "never, within the window".
  int _daysSinceLastDone(Set<DateTime> doneDates, DateTime day) {
    if (doneDates.isEmpty) return historyWindowDays + 1;
    final latest = doneDates.reduce((a, b) => a.isAfter(b) ? a : b);
    return day.difference(latest).inDays;
  }

  String _reasonFor({
    required bool completedToday,
    required int streak,
    required int daysSinceDone,
    required double pillarWeakness,
  }) {
    if (completedToday) return 'Done today ✓';
    if (streak >= 2) return 'Keep your $streak-day streak alive';
    if (daysSinceDone > historyWindowDays) return 'You haven\'t done this in a while';
    if (pillarWeakness >= 70) return 'This pillar needs attention';
    return 'A good next step today';
  }
}
