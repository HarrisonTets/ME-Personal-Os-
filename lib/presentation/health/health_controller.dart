import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/health_log.dart';
import '../../domain/usecases/summarize_health_day.dart';
import '../providers/app_providers.dart';

/// Local midnight today, fixed for the session.
final _todayProvider = Provider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

/// Live list of today's wellness logs, newest first.
final todaysHealthLogsProvider =
    StreamProvider.autoDispose<List<HealthLog>>((ref) {
  final day = ref.watch(_todayProvider);
  return ref.watch(healthRepositoryProvider).watchLogsForDate(day);
});

/// Today's totals per activity type, recomputed whenever logs change.
final todaysHealthSummaryProvider = Provider.autoDispose<HealthSummary>((ref) {
  final logs = ref.watch(todaysHealthLogsProvider).value ?? const [];
  return ref.watch(summarizeHealthDayProvider)(logs);
});
