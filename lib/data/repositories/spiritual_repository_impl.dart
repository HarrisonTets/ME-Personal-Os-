import 'package:drift/drift.dart';

import '../../domain/entities/bible_plan.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/repositories/spiritual_repository.dart';
import '../local/app_database.dart';

/// Drift-backed [SpiritualRepository]. Maps between Drift rows and the domain
/// entities so storage details stay behind this boundary.
class SpiritualRepositoryImpl implements SpiritualRepository {
  SpiritualRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<BiblePlan?> getActivePlan() async {
    final row = await (_db.select(_db.biblePlans)
          ..where((p) => p.active.equals(true))
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _toPlan(row);
  }

  @override
  Stream<List<ReadingAssignment>> watchAssignments(String planId) {
    return (_db.select(_db.readingAssignments)
          ..where((a) => a.planId.equals(planId))
          ..orderBy([(a) => OrderingTerm(expression: a.dayNumber)]))
        .watch()
        .map((rows) => rows.map(_toAssignment).toList());
  }

  @override
  Future<void> completeAssignment({
    required String assignmentId,
    required DateTime when,
  }) async {
    await (_db.update(_db.readingAssignments)
          ..where((a) => a.id.equals(assignmentId)))
        .write(ReadingAssignmentsCompanion(completedAt: Value(when)));
  }

  @override
  Future<void> addJournalEntry(JournalEntry entry) async {
    await _db.into(_db.journalEntries).insert(
          JournalEntriesCompanion.insert(
            id: entry.id,
            reference: entry.reference,
            body: entry.body,
            createdAt: entry.createdAt,
            assignmentId: Value(entry.assignmentId),
          ),
        );
  }

  @override
  Stream<List<JournalEntry>> watchJournal() {
    return (_db.select(_db.journalEntries)
          ..orderBy([
            (e) => OrderingTerm(
                  expression: e.createdAt,
                  mode: OrderingMode.desc,
                )
          ]))
        .watch()
        .map((rows) => rows.map(_toJournal).toList());
  }

  // --- mappers -----------------------------------------------------------
  BiblePlan _toPlan(BiblePlanRow row) => BiblePlan(
        id: row.id,
        name: row.name,
        description: row.description,
        totalDays: row.totalDays,
      );

  ReadingAssignment _toAssignment(ReadingAssignmentRow row) =>
      ReadingAssignment(
        id: row.id,
        planId: row.planId,
        dayNumber: row.dayNumber,
        reference: row.reference,
        completedAt: row.completedAt,
      );

  JournalEntry _toJournal(JournalEntryRow row) => JournalEntry(
        id: row.id,
        reference: row.reference,
        body: row.body,
        createdAt: row.createdAt,
        assignmentId: row.assignmentId,
      );
}
