import '../entities/finance_entry.dart';

/// Storage promise for the Finance pillar.
abstract interface class FinanceRepository {
  /// Adds a new income/expense entry.
  Future<void> addEntry(FinanceEntry entry);

  /// Removes an entry by id.
  Future<void> deleteEntry(String id);

  /// Live list of entries on or after [from], newest first. Used for the
  /// "this week" view and the recent list.
  Stream<List<FinanceEntry>> watchEntriesSince(DateTime from);
}
