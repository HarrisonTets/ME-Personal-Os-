import 'package:drift/drift.dart';

import '../../domain/entities/finance_entry.dart';
import '../../domain/repositories/finance_repository.dart';
import '../local/app_database.dart';

/// Drift-backed [FinanceRepository].
class FinanceRepositoryImpl implements FinanceRepository {
  FinanceRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> addEntry(FinanceEntry entry) async {
    await _db.into(_db.financeEntries).insert(
          FinanceEntriesCompanion.insert(
            id: entry.id,
            type: entry.type.storageKey,
            amount: entry.amount,
            category: entry.category.storageKey,
            date: entry.date,
            note: Value(entry.note),
          ),
        );
  }

  @override
  Future<void> deleteEntry(String id) async {
    await (_db.delete(_db.financeEntries)..where((e) => e.id.equals(id))).go();
  }

  @override
  Stream<List<FinanceEntry>> watchEntriesSince(DateTime from) {
    return (_db.select(_db.financeEntries)
          ..where((e) => e.date.isBiggerOrEqualValue(from))
          ..orderBy([
            (e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc),
          ]))
        .watch()
        .map((rows) => rows.map(_toEntry).toList());
  }

  FinanceEntry _toEntry(FinanceEntryRow row) => FinanceEntry(
        id: row.id,
        type: FinanceType.fromStorage(row.type),
        amount: row.amount,
        category: FinanceCategory.fromStorage(row.category),
        date: row.date,
        note: row.note,
      );
}
