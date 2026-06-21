import 'package:drift/drift.dart';

import '../../domain/entities/reflection.dart' show Scale;
import '../../domain/entities/weekly_reflection.dart';
import '../../domain/repositories/weekly_reflection_repository.dart';
import '../local/app_database.dart';

/// Drift-backed [WeeklyReflectionRepository].
class WeeklyReflectionRepositoryImpl implements WeeklyReflectionRepository {
  WeeklyReflectionRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> saveForWeek(WeeklyReflection reflection) async {
    final week = DateTime(reflection.weekStart.year, reflection.weekStart.month,
        reflection.weekStart.day);
    final next = week.add(const Duration(days: 7));
    // One reflection per week: clear any existing for that week, then insert.
    await (_db.delete(_db.weeklyReflections)
          ..where((r) =>
              r.weekStart.isBiggerOrEqualValue(week) &
              r.weekStart.isSmallerThanValue(next)))
        .go();
    await _db.into(_db.weeklyReflections).insert(
          WeeklyReflectionsCompanion.insert(
            id: reflection.id,
            weekStart: week,
            alignment: reflection.alignment.storageKey,
            bodyFeel: reflection.bodyFeel.storageKey,
            oneChange: Value(reflection.oneChange),
            createdAt: reflection.createdAt,
          ),
        );
  }

  @override
  Stream<WeeklyReflection?> watchForWeek(DateTime weekStart) {
    final week =
        DateTime(weekStart.year, weekStart.month, weekStart.day);
    final next = week.add(const Duration(days: 7));
    return (_db.select(_db.weeklyReflections)
          ..where((r) =>
              r.weekStart.isBiggerOrEqualValue(week) &
              r.weekStart.isSmallerThanValue(next))
          ..limit(1))
        .watch()
        .map((rows) => rows.isEmpty ? null : _toReflection(rows.first));
  }

  WeeklyReflection _toReflection(WeeklyReflectionRow row) => WeeklyReflection(
        id: row.id,
        weekStart: row.weekStart,
        alignment: Scale.fromStorage(row.alignment),
        bodyFeel: Scale.fromStorage(row.bodyFeel),
        oneChange: row.oneChange,
        createdAt: row.createdAt,
      );
}
