import 'package:uuid/uuid.dart';

import '../entities/health_log.dart';
import '../repositories/health_repository.dart';
import 'auto_complete_habits.dart';

/// Creates and stores a wellness log, generating its id and normalising the
/// date, then ticks the matching health habit on Today (water / walk).
class AddHealthLog {
  const AddHealthLog(this._repository, this._autoComplete);

  final HealthRepository _repository;
  final AutoCompleteHabits _autoComplete;
  static const _uuid = Uuid();

  Future<void> call({
    required HealthLogType type,
    required double value,
    required DateTime date,
    String? note,
  }) async {
    final day = DateTime(date.year, date.month, date.day);
    await _repository.addLog(
      HealthLog(
        id: _uuid.v4(),
        type: type,
        value: value,
        date: day,
        note: note,
      ),
    );

    // Map the logged activity to its Today habit, if any.
    final trigger = switch (type) {
      HealthLogType.water => HabitTriggers.healthWater,
      HealthLogType.walk => HabitTriggers.healthWalk,
      _ => null,
    };
    if (trigger != null) await _autoComplete(trigger, day);
  }
}
