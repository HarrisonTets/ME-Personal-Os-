import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/app_database.dart';
import '../../data/repositories/finance_repository_impl.dart';
import '../../data/repositories/focus_repository_impl.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../data/repositories/health_repository_impl.dart';
import '../../data/repositories/spiritual_repository_impl.dart';
import '../../domain/repositories/finance_repository.dart';
import '../../domain/repositories/focus_repository.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../domain/repositories/health_repository.dart';
import '../../domain/repositories/spiritual_repository.dart';
import '../../domain/usecases/add_finance_entry.dart';
import '../../domain/usecases/add_focus_session.dart';
import '../../domain/usecases/add_health_log.dart';
import '../../domain/usecases/auto_complete_habits.dart';
import '../../domain/usecases/complete_quiet_time.dart';
import '../../domain/usecases/generate_today_suggestions.dart';
import '../../domain/usecases/summarize_focus.dart';
import '../../domain/usecases/summarize_health_day.dart';
import '../../domain/usecases/summarize_spending.dart';

/// Single app-wide Drift database. Overridden in [main] with the concrete
/// instance so the rest of the app depends only on this provider.
final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('appDatabaseProvider must be overridden'),
);

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => HabitRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final generateTodaySuggestionsProvider = Provider<GenerateTodaySuggestions>(
  (ref) => const GenerateTodaySuggestions(),
);

/// Cross-pillar glue: ticks Today habits when a matching activity happens.
final autoCompleteHabitsProvider = Provider<AutoCompleteHabits>(
  (ref) => AutoCompleteHabits(ref.watch(habitRepositoryProvider)),
);

final spiritualRepositoryProvider = Provider<SpiritualRepository>(
  (ref) => SpiritualRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final completeQuietTimeProvider = Provider<CompleteQuietTime>(
  (ref) => CompleteQuietTime(
    ref.watch(spiritualRepositoryProvider),
    ref.watch(autoCompleteHabitsProvider),
  ),
);

final financeRepositoryProvider = Provider<FinanceRepository>(
  (ref) => FinanceRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final summarizeSpendingProvider = Provider<SummarizeSpending>(
  (ref) => const SummarizeSpending(),
);

final addFinanceEntryProvider = Provider<AddFinanceEntry>(
  (ref) => AddFinanceEntry(
    ref.watch(financeRepositoryProvider),
    ref.watch(autoCompleteHabitsProvider),
  ),
);

final focusRepositoryProvider = Provider<FocusRepository>(
  (ref) => FocusRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final addFocusSessionProvider = Provider<AddFocusSession>(
  (ref) => AddFocusSession(
    ref.watch(focusRepositoryProvider),
    ref.watch(autoCompleteHabitsProvider),
  ),
);

final summarizeFocusProvider = Provider<SummarizeFocus>(
  (ref) => const SummarizeFocus(),
);

final healthRepositoryProvider = Provider<HealthRepository>(
  (ref) => HealthRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final addHealthLogProvider = Provider<AddHealthLog>(
  (ref) => AddHealthLog(
    ref.watch(healthRepositoryProvider),
    ref.watch(autoCompleteHabitsProvider),
  ),
);

final summarizeHealthDayProvider = Provider<SummarizeHealthDay>(
  (ref) => const SummarizeHealthDay(),
);
