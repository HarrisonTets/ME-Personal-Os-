import 'package:drift/drift.dart';

import '../../domain/entities/focus_session.dart';
import '../../domain/repositories/focus_repository.dart';
import '../local/app_database.dart';

/// Drift-backed [FocusRepository].
class FocusRepositoryImpl implements FocusRepository {
  FocusRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> saveSession(FocusSession session) async {
    await _db.into(_db.focusSessions).insert(
          FocusSessionsCompanion.insert(
            id: session.id,
            intention: session.intention,
            plannedMinutes: session.plannedMinutes,
            focusedMinutes: session.focusedMinutes,
            completed: session.completed,
            startedAt: session.startedAt,
          ),
        );
  }

  @override
  Stream<List<FocusSession>> watchSessionsSince(DateTime from) {
    return (_db.select(_db.focusSessions)
          ..where((s) => s.startedAt.isBiggerOrEqualValue(from))
          ..orderBy([
            (s) =>
                OrderingTerm(expression: s.startedAt, mode: OrderingMode.desc),
          ]))
        .watch()
        .map((rows) => rows.map(_toSession).toList());
  }

  FocusSession _toSession(FocusSessionRow row) => FocusSession(
        id: row.id,
        intention: row.intention,
        plannedMinutes: row.plannedMinutes,
        focusedMinutes: row.focusedMinutes,
        completed: row.completed,
        startedAt: row.startedAt,
      );
}
