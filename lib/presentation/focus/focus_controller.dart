import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/focus_session.dart';
import '../../domain/usecases/summarize_focus.dart';
import '../providers/app_providers.dart';

/// Local midnight today, fixed for the session.
final _todayProvider = Provider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

/// Live list of today's focus sessions, newest first.
final todaysSessionsProvider =
    StreamProvider.autoDispose<List<FocusSession>>((ref) {
  final from = ref.watch(_todayProvider);
  return ref.watch(focusRepositoryProvider).watchSessionsSince(from);
});

/// Today's roll-up (session count + total focused minutes), recomputed whenever
/// sessions change.
final todaysFocusSummaryProvider = Provider.autoDispose<FocusSummary>((ref) {
  final sessions = ref.watch(todaysSessionsProvider).value ?? const [];
  return ref.watch(summarizeFocusProvider)(sessions);
});
