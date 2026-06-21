import 'package:flutter_test/flutter_test.dart';
import 'package:personal_os/domain/entities/habit.dart';
import 'package:personal_os/domain/entities/habit_log.dart';
import 'package:personal_os/domain/entities/pillar.dart';
import 'package:personal_os/domain/repositories/habit_repository.dart';
import 'package:personal_os/domain/usecases/auto_complete_habits.dart';

/// Minimal in-memory [HabitRepository] that records setLog calls, so we can
/// assert which habits the use case marked done.
class FakeHabitRepository implements HabitRepository {
  FakeHabitRepository(this._habits);
  final List<Habit> _habits;
  final markedDone = <String>[];

  @override
  Future<List<Habit>> getActiveHabits() async => _habits;

  @override
  Future<void> setLog({
    required String habitId,
    required DateTime date,
    required HabitLogStatus status,
  }) async {
    markedDone.add(habitId);
  }

  // Unused by AutoCompleteHabits.
  @override
  Future<void> setHabitsActiveForPillars(Set<PillarType> enabledPillars) async {}
  @override
  Future<void> clearLog({required String habitId, required DateTime date}) async {}
  @override
  Future<List<HabitLog>> getLogsSince(DateTime from) async => [];
  @override
  Stream<List<HabitLog>> watchLogsForDate(DateTime date) => Stream.value([]);
}

void main() {
  Habit habit(String id, String? trigger) => Habit(
        id: id,
        name: id,
        pillar: PillarType.health,
        difficulty: HabitDifficulty.light,
        estimatedMinutes: 5,
        triggerKey: trigger,
      );

  test('marks only habits whose triggerKey matches', () async {
    final repo = FakeHabitRepository([
      habit('water', 'health_water'),
      habit('walk', 'health_walk'),
      habit('manual', null),
    ]);
    final useCase = AutoCompleteHabits(repo);

    await useCase('health_water', DateTime(2026, 6, 19));

    expect(repo.markedDone, ['water']);
  });

  test('marks nothing when no habit matches the trigger', () async {
    final repo = FakeHabitRepository([habit('manual', null)]);
    await AutoCompleteHabits(repo)('focus_session', DateTime(2026, 6, 19));
    expect(repo.markedDone, isEmpty);
  });
}
