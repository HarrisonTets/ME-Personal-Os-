import '../entities/bible_plan.dart';
import '../entities/journal_entry.dart';

/// Storage promise for the Spiritual / Bible pillar. The domain depends only on
/// this shape; Drift fulfills it in the data layer.
abstract interface class SpiritualRepository {
  /// The currently active reading plan, if one has been started/seeded.
  Future<BiblePlan?> getActivePlan();

  /// All assignments for a plan, ordered by day number. Emits again whenever a
  /// reading is completed, so progress UI updates live.
  Stream<List<ReadingAssignment>> watchAssignments(String planId);

  /// Marks a reading finished at [when].
  Future<void> completeAssignment({
    required String assignmentId,
    required DateTime when,
  });

  /// Adds a journal reflection.
  Future<void> addJournalEntry(JournalEntry entry);

  /// The spiritual journal timeline, newest first, kept live.
  Stream<List<JournalEntry>> watchJournal();
}
