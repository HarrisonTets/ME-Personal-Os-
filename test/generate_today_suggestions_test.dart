import 'package:flutter_test/flutter_test.dart';
import 'package:personal_os/domain/entities/habit.dart';
import 'package:personal_os/domain/entities/habit_log.dart';
import 'package:personal_os/domain/entities/pillar.dart';
import 'package:personal_os/domain/usecases/generate_today_suggestions.dart';

void main() {
  final today = DateTime(2026, 6, 19);

  Habit habit(String id, PillarType pillar,
          {HabitDifficulty difficulty = HabitDifficulty.medium}) =>
      Habit(
        id: id,
        name: 'Habit $id',
        pillar: pillar,
        difficulty: difficulty,
        estimatedMinutes: 10,
      );

  HabitLog log(String habitId, DateTime date) => HabitLog(
        id: '$habitId-${date.toIso8601String()}',
        habitId: habitId,
        date: date,
        status: HabitLogStatus.done,
      );

  test('respects the daily budget for outstanding suggestions', () {
    final habits = [
      for (var i = 0; i < 10; i++)
        habit('h$i', PillarType.values[i % PillarType.values.length]),
    ];
    const engine = GenerateTodaySuggestions(dailyBudget: 3, maxPerPillar: 5);

    final result = engine(habits: habits, recentLogs: [], today: today);
    final outstanding = result.where((s) => !s.completedToday);

    expect(outstanding.length, 3);
  });

  test('enforces pillar diversity via maxPerPillar', () {
    final habits = [
      for (var i = 0; i < 5; i++) habit('f$i', PillarType.finance),
      habit('h0', PillarType.health),
    ];
    const engine = GenerateTodaySuggestions(dailyBudget: 5, maxPerPillar: 2);

    final result = engine(habits: habits, recentLogs: [], today: today);
    final financeCount = result
        .where((s) => !s.completedToday && s.habit.pillar == PillarType.finance)
        .length;

    expect(financeCount, lessThanOrEqualTo(2));
  });

  test('marks habits done today and keeps them out of the budget', () {
    final habits = [habit('a', PillarType.focus), habit('b', PillarType.health)];
    final result = GenerateTodaySuggestions(dailyBudget: 5)(
      habits: habits,
      recentLogs: [log('a', today)],
      today: today,
    );

    final a = result.firstWhere((s) => s.habit.id == 'a');
    expect(a.completedToday, isTrue);
  });

  test('prioritises a weaker pillar over a consistently-completed one', () {
    final habits = [
      habit('strong', PillarType.finance),
      habit('weak', PillarType.health),
    ];
    // "strong" was done every day for the past week; "weak" never.
    final logs = [
      for (var d = 1; d <= 7; d++)
        log('strong', today.subtract(Duration(days: d))),
    ];
    const engine = GenerateTodaySuggestions(dailyBudget: 1, maxPerPillar: 1);

    final result = engine(habits: habits, recentLogs: logs, today: today);
    final outstanding = result.where((s) => !s.completedToday).toList();

    expect(outstanding.first.habit.id, 'weak');
  });
}
