import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/finance_entry.dart';
import '../../domain/usecases/summarize_spending.dart';
import '../providers/app_providers.dart';

/// Start of the current week (Monday, local midnight), fixed for the session.
final weekStartProvider = Provider<DateTime>((ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  // weekday: Mon=1 … Sun=7 → step back to Monday.
  return today.subtract(Duration(days: today.weekday - 1));
});

/// Live list of this week's entries, newest first.
final weeklyEntriesProvider =
    StreamProvider.autoDispose<List<FinanceEntry>>((ref) {
  final from = ref.watch(weekStartProvider);
  return ref.watch(financeRepositoryProvider).watchEntriesSince(from);
});

/// Rolled-up summary (totals + top categories) for this week, recomputed
/// whenever the entries change.
final weeklySummaryProvider = Provider.autoDispose<SpendingSummary>((ref) {
  final entries = ref.watch(weeklyEntriesProvider).value ?? const [];
  return ref.watch(summarizeSpendingProvider)(entries);
});
