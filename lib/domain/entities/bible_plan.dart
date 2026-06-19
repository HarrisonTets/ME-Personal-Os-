/// A structured Bible reading plan made of sequential daily assignments
/// (e.g. "Gospel of John" = 21 days, one chapter each).
class BiblePlan {
  const BiblePlan({
    required this.id,
    required this.name,
    required this.description,
    required this.totalDays,
  });

  final String id;
  final String name;
  final String description;
  final int totalDays;
}

/// One day's reading within a [BiblePlan]. [completedAt] is null until the user
/// finishes it; that's how we track progress and find "today's" reading.
class ReadingAssignment {
  const ReadingAssignment({
    required this.id,
    required this.planId,
    required this.dayNumber,
    required this.reference,
    this.completedAt,
  });

  final String id;
  final String planId;

  /// 1-based position in the plan (Day 1, Day 2, …).
  final int dayNumber;

  /// Human-readable passage, e.g. "John 3".
  final String reference;
  final DateTime? completedAt;

  bool get isCompleted => completedAt != null;

  ReadingAssignment copyWith({DateTime? completedAt}) => ReadingAssignment(
        id: id,
        planId: planId,
        dayNumber: dayNumber,
        reference: reference,
        completedAt: completedAt ?? this.completedAt,
      );
}
