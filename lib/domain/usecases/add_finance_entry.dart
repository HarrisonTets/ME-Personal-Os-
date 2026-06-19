import 'package:uuid/uuid.dart';

import '../entities/finance_entry.dart';
import '../repositories/finance_repository.dart';
import 'auto_complete_habits.dart';

/// Creates and stores a finance entry, generating its id, then ticks the
/// matching "log expenses" habit on Today. Keeps id-generation out of the UI.
class AddFinanceEntry {
  const AddFinanceEntry(this._repository, this._autoComplete);

  final FinanceRepository _repository;
  final AutoCompleteHabits _autoComplete;
  static const _uuid = Uuid();

  Future<void> call({
    required FinanceType type,
    required double amount,
    required FinanceCategory category,
    required DateTime date,
    String? note,
  }) async {
    await _repository.addEntry(
      FinanceEntry(
        id: _uuid.v4(),
        type: type,
        amount: amount,
        category: category,
        date: date,
        note: note,
      ),
    );
    await _autoComplete(HabitTriggers.financeLog, date);
  }
}
