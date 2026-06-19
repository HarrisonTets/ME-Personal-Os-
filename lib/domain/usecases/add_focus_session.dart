import 'package:uuid/uuid.dart';

import '../entities/focus_session.dart';
import '../repositories/focus_repository.dart';
import 'auto_complete_habits.dart';

/// Creates and stores a finished focus session, generating its id. If the
/// session ran to completion, it also ticks the matching focus habit on Today.
class AddFocusSession {
  const AddFocusSession(this._repository, this._autoComplete);

  final FocusRepository _repository;
  final AutoCompleteHabits _autoComplete;
  static const _uuid = Uuid();

  Future<void> call({
    required String intention,
    required int plannedMinutes,
    required int focusedMinutes,
    required bool completed,
    required DateTime startedAt,
  }) async {
    await _repository.saveSession(
      FocusSession(
        id: _uuid.v4(),
        intention: intention,
        plannedMinutes: plannedMinutes,
        focusedMinutes: focusedMinutes,
        completed: completed,
        startedAt: startedAt,
      ),
    );
    // Only a completed session counts toward the "do a focus session" habit.
    if (completed) {
      await _autoComplete(HabitTriggers.focusSession, startedAt);
    }
  }
}
