import 'package:drift/drift.dart';

import '../../domain/entities/health_log.dart';
import '../../domain/repositories/health_repository.dart';
import '../local/app_database.dart';

/// Drift-backed [HealthRepository].
class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> addLog(HealthLog log) async {
    await _db.into(_db.healthLogs).insert(
          HealthLogsCompanion.insert(
            id: log.id,
            type: log.type.storageKey,
            value: log.value,
            date: log.date,
            note: Value(log.note),
          ),
        );
  }

  @override
  Future<void> deleteLog(String id) async {
    await (_db.delete(_db.healthLogs)..where((l) => l.id.equals(id))).go();
  }

  @override
  Stream<List<HealthLog>> watchLogsForDate(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final next = day.add(const Duration(days: 1));
    return (_db.select(_db.healthLogs)
          ..where((l) =>
              l.date.isBiggerOrEqualValue(day) &
              l.date.isSmallerThanValue(next))
          ..orderBy([
            (l) => OrderingTerm(expression: l.id, mode: OrderingMode.desc),
          ]))
        .watch()
        .map((rows) => rows.map(_toLog).toList());
  }

  HealthLog _toLog(HealthLogRow row) => HealthLog(
        id: row.id,
        type: HealthLogType.fromStorage(row.type),
        value: row.value,
        date: row.date,
        note: row.note,
      );
}
