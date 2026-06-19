import 'package:uuid/uuid.dart';

import '../entities/bible_plan.dart';
import '../entities/journal_entry.dart';
import '../repositories/spiritual_repository.dart';
import 'auto_complete_habits.dart';

/// Finishing a Quiet Time is several things at once: mark today's reading done,
/// save the reflection (if any) to the journal, and tick the matching habit on
/// Today. Bundling them keeps the rule in the domain rather than the UI.
class CompleteQuietTime {
  const CompleteQuietTime(this._repository, this._autoComplete);

  final SpiritualRepository _repository;
  final AutoCompleteHabits _autoComplete;
  static const _uuid = Uuid();

  Future<void> call({
    required ReadingAssignment assignment,
    required String reflection,
    required DateTime now,
  }) async {
    await _repository.completeAssignment(
      assignmentId: assignment.id,
      when: now,
    );

    final text = reflection.trim();
    if (text.isNotEmpty) {
      await _repository.addJournalEntry(
        JournalEntry(
          id: _uuid.v4(),
          reference: assignment.reference,
          body: text,
          createdAt: now,
          assignmentId: assignment.id,
        ),
      );
    }

    // Cross-pillar: auto-tick the "Read today's passage" habit on Today.
    await _autoComplete(HabitTriggers.bibleReading, now);
  }
}
