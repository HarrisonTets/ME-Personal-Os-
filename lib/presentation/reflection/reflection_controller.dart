import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/reflection.dart';
import '../providers/app_providers.dart';

/// Local midnight today, fixed for the session.
final reflectionTodayProvider = Provider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

/// Today's reflection (null until the user fills it in), kept live.
final todaysReflectionProvider =
    StreamProvider.autoDispose<Reflection?>((ref) {
  final day = ref.watch(reflectionTodayProvider);
  return ref.watch(reflectionRepositoryProvider).watchForDate(day);
});

/// Recent reflections for the history list.
final recentReflectionsProvider =
    StreamProvider.autoDispose<List<Reflection>>((ref) {
  return ref.watch(reflectionRepositoryProvider).watchRecent();
});
