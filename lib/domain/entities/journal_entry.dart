/// A reflection the user writes during Quiet Time, optionally tied to the
/// passage they read. Forms the spiritual journal timeline.
class JournalEntry {
  const JournalEntry({
    required this.id,
    required this.reference,
    required this.body,
    required this.createdAt,
    this.assignmentId,
  });

  final String id;

  /// Passage this reflection relates to, e.g. "John 3" (may be free-form).
  final String reference;

  /// The user's written reflection.
  final String body;
  final DateTime createdAt;

  /// Links back to the [ReadingAssignment] this came from, when applicable.
  final String? assignmentId;
}
