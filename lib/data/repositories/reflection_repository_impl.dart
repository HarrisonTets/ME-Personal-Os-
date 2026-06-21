import 'package:drift/drift.dart';

import '../../domain/entities/reflection.dart';
import '../../domain/repositories/reflection_repository.dart';
import '../local/app_database.dart';

/// Drift-backed [ReflectionRepository].
class ReflectionRepositoryImpl implements ReflectionRepository {
  ReflectionRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> saveForDate(Reflection reflection) async {
    final day = DateTime(
        reflection.date.year, reflection.date.month, reflection.date.day);
    final next = day.add(const Duration(days: 1));
    // One reflection per day: clear any existing for that day, then insert.
    await (_db.delete(_db.reflections)
          ..where((r) =>
              r.date.isBiggerOrEqualValue(day) &
              r.date.isSmallerThanValue(next)))
        .go();
    await _db.into(_db.reflections).insert(
          ReflectionsCompanion.insert(
            id: reflection.id,
            date: day,
            mood: reflection.mood.storageKey,
            energy: reflection.energy.storageKey,
            drained: Value(reflection.drained),
            energized: Value(reflection.energized),
            createdAt: reflection.createdAt,
          ),
        );
  }

  @override
  Stream<Reflection?> watchForDate(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final next = day.add(const Duration(days: 1));
    return (_db.select(_db.reflections)
          ..where((r) =>
              r.date.isBiggerOrEqualValue(day) &
              r.date.isSmallerThanValue(next))
          ..limit(1))
        .watch()
        .map((rows) => rows.isEmpty ? null : _toReflection(rows.first));
  }

  @override
  Stream<List<Reflection>> watchRecent({int limit = 30}) {
    return (_db.select(_db.reflections)
          ..orderBy([
            (r) => OrderingTerm(expression: r.date, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .watch()
        .map((rows) => rows.map(_toReflection).toList());
  }

  Reflection _toReflection(ReflectionRow row) => Reflection(
        id: row.id,
        date: row.date,
        mood: Scale.fromStorage(row.mood),
        energy: Scale.fromStorage(row.energy),
        drained: row.drained,
        energized: row.energized,
        createdAt: row.createdAt,
      );
}
