import 'package:flutter_test/flutter_test.dart';
import 'package:personal_os/domain/entities/habit.dart';
import 'package:personal_os/domain/entities/habit_log.dart';
import 'package:personal_os/domain/entities/pillar.dart';
import 'package:personal_os/domain/usecases/compute_pillar_scores.dart';

void main() {
  final today = DateTime(2026, 6, 20);

  Habit habit(String id, PillarType pillar) => Habit(
        id: id,
        name: id,
        pillar: pillar,
        difficulty: HabitDifficulty.light,
        estimatedMinutes: 5,
      );

  HabitLog log(String habitId, DateTime date) => HabitLog(
        id: '$habitId-${date.toIso8601String()}',
        habitId: habitId,
        date: date,
        status: HabitLogStatus.done,
      );

  test('only includes pillars that have habits', () {
    final scores = const ComputePillarScores()(
      habits: [habit('a', PillarType.health)],
      recentLogs: [],
      today: today,
    );
    expect(scores.length, 1);
    expect(scores.single.pillar, PillarType.health);
  });

  test('a habit done every day in the window scores 100', () {
    final logs = [
      for (var d = 0; d < 7; d++) log('a', today.subtract(Duration(days: d))),
    ];
    final scores = const ComputePillarScores(windowDays: 7)(
      habits: [habit('a', PillarType.focus)],
      recentLogs: logs,
      today: today,
    );
    expect(scores.single.score, 100);
  });

  test('never completed scores 0', () {
    final scores = const ComputePillarScores()(
      habits: [habit('a', PillarType.finance)],
      recentLogs: [],
      today: today,
    );
    expect(scores.single.score, 0);
  });

  test('partial completion scales between 0 and 100', () {
    // Done 3 of the last 7 days → ~43%.
    final logs = [
      for (var d = 0; d < 3; d++) log('a', today.subtract(Duration(days: d))),
    ];
    final scores = const ComputePillarScores(windowDays: 7)(
      habits: [habit('a', PillarType.learning)],
      recentLogs: logs,
      today: today,
    );
    expect(scores.single.score, 43); // (3/7*100).round()
  });
}
