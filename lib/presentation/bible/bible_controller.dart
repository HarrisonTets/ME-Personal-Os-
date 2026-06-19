import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/bible_plan.dart';
import '../../domain/entities/journal_entry.dart';
import '../providers/app_providers.dart';

/// The active reading plan (seeded "Gospel of John"), loaded once.
final activePlanProvider = FutureProvider<BiblePlan?>(
  (ref) => ref.watch(spiritualRepositoryProvider).getActivePlan(),
);

/// Live list of the plan's daily assignments, ordered by day. Re-emits whenever
/// a reading is completed.
final assignmentsProvider =
    StreamProvider.autoDispose<List<ReadingAssignment>>((ref) {
  final plan = ref.watch(activePlanProvider).value;
  if (plan == null) return Stream.value(const []);
  return ref.watch(spiritualRepositoryProvider).watchAssignments(plan.id);
});

/// Live spiritual journal timeline, newest first.
final journalProvider = StreamProvider.autoDispose<List<JournalEntry>>(
  (ref) => ref.watch(spiritualRepositoryProvider).watchJournal(),
);

/// A small computed view of "where am I in the plan" for the Bible home screen.
class BibleProgress {
  const BibleProgress({
    required this.plan,
    required this.completed,
    required this.total,
    required this.todaysReading,
  });

  final BiblePlan plan;
  final int completed;
  final int total;

  /// The next unread assignment (what to do today), or null if the plan's done.
  final ReadingAssignment? todaysReading;

  double get fraction => total == 0 ? 0 : completed / total;
  bool get isPlanComplete => todaysReading == null;
}

/// Combines the plan + assignments into [BibleProgress]. Returns null while the
/// plan is still loading.
final bibleProgressProvider = Provider.autoDispose<BibleProgress?>((ref) {
  final plan = ref.watch(activePlanProvider).value;
  final assignments = ref.watch(assignmentsProvider).value;
  if (plan == null || assignments == null) return null;

  ReadingAssignment? todays;
  var completed = 0;
  for (final a in assignments) {
    if (a.isCompleted) {
      completed++;
    } else {
      todays ??= a; // first incomplete = today's reading
    }
  }

  return BibleProgress(
    plan: plan,
    completed: completed,
    total: plan.totalDays,
    todaysReading: todays,
  );
});
