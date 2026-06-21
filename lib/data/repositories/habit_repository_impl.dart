import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_log.dart';
import '../../domain/entities/pillar.dart';
import '../../domain/repositories/habit_repository.dart';
import '../local/app_database.dart';

/// Drift-backed [HabitRepository]. Translates between Drift row classes and the
/// domain entities, so persistence details never leak past this boundary.
class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  @override
  Future<void> setHabitsActiveForPillars(Set<PillarType> enabledPillars) async {
    for (final pillar in PillarType.values) {
      await (_db.update(_db.habits)
            ..where((h) => h.pillar.equals(pillar.storageKey)))
          .write(HabitsCompanion(active: Value(enabledPillars.contains(pillar))));
    }
  }

  @override
  Future<List<Habit>> getActiveHabits() async {
    final rows = await (_db.select(_db.habits)
          ..where((h) => h.active.equals(true))
          ..orderBy([(h) => OrderingTerm(expression: h.createdAt)]))
        .get();
    return rows.map(_toHabit).toList();
  }

  @override
  Future<List<HabitLog>> getLogsSince(DateTime from) async {
    final start = HabitLog.dateOnly(from);
    final rows = await (_db.select(_db.habitLogs)
          ..where((l) => l.date.isBiggerOrEqualValue(start)))
        .get();
    return rows.map(_toLog).toList();
  }

  @override
  Future<void> setLog({
    required String habitId,
    required DateTime date,
    required HabitLogStatus status,
  }) async {
    final day = HabitLog.dateOnly(date);
    // One log per habit/day: clear any existing then insert, so repeated
    // toggles stay idempotent.
    await _deleteLog(habitId, day);
    await _db.into(_db.habitLogs).insert(
          HabitLogsCompanion.insert(
            id: _uuid.v4(),
            habitId: habitId,
            date: day,
            status: status.storageKey,
          ),
        );
  }

  @override
  Future<void> clearLog({
    required String habitId,
    required DateTime date,
  }) {
    return _deleteLog(habitId, HabitLog.dateOnly(date));
  }

  @override
  Stream<List<HabitLog>> watchLogsForDate(DateTime date) {
    final day = HabitLog.dateOnly(date);
    final next = day.add(const Duration(days: 1));
    return (_db.select(_db.habitLogs)
          ..where((l) =>
              l.date.isBiggerOrEqualValue(day) & l.date.isSmallerThanValue(next)))
        .watch()
        .map((rows) => rows.map(_toLog).toList());
  }

  Future<void> _deleteLog(String habitId, DateTime day) {
    final next = day.add(const Duration(days: 1));
    return (_db.delete(_db.habitLogs)
          ..where((l) =>
              l.habitId.equals(habitId) &
              l.date.isBiggerOrEqualValue(day) &
              l.date.isSmallerThanValue(next)))
        .go();
  }

  // --- mappers -----------------------------------------------------------
  Habit _toHabit(HabitRow row) => Habit(
        id: row.id,
        name: row.name,
        description: row.description,
        pillar: PillarType.fromStorage(row.pillar),
        difficulty: HabitDifficulty.fromStorage(row.difficulty),
        estimatedMinutes: row.estimatedMinutes,
        active: row.active,
        triggerKey: row.triggerKey,
      );

  HabitLog _toLog(HabitLogRow row) => HabitLog(
        id: row.id,
        habitId: row.habitId,
        date: row.date,
        status: HabitLogStatus.fromStorage(row.status),
        mood: row.mood,
        notes: row.notes,
      );
}
