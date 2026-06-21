import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/entities/pillar.dart';
import '../providers/app_providers.dart';

/// In-memory view of the app's settings, parsed from the key-value store.
class SettingsState {
  const SettingsState({
    required this.onboardingComplete,
    required this.dailyBudget,
    required this.reminderIntensity,
    required this.enabledPillars,
  });

  final bool onboardingComplete;
  final int dailyBudget;
  final ReminderIntensity reminderIntensity;
  final Set<PillarType> enabledPillars;

  /// Defaults used before the user has onboarded.
  static final initial = SettingsState(
    onboardingComplete: false,
    dailyBudget: 5,
    reminderIntensity: ReminderIntensity.medium,
    enabledPillars: PillarType.values.toSet(),
  );

  SettingsState copyWith({
    bool? onboardingComplete,
    int? dailyBudget,
    ReminderIntensity? reminderIntensity,
    Set<PillarType>? enabledPillars,
  }) {
    return SettingsState(
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      dailyBudget: dailyBudget ?? this.dailyBudget,
      reminderIntensity: reminderIntensity ?? this.reminderIntensity,
      enabledPillars: enabledPillars ?? this.enabledPillars,
    );
  }
}

/// Loads settings from storage and exposes them, plus the onboarding write.
class SettingsController extends AsyncNotifier<SettingsState> {
  @override
  Future<SettingsState> build() async {
    final map = await ref.watch(settingsRepositoryProvider).getAll();
    return _parse(map);
  }

  SettingsState _parse(Map<String, String> map) {
    final pillarsRaw = map[SettingsKeys.enabledPillars];
    final pillars = (pillarsRaw == null || pillarsRaw.isEmpty)
        ? PillarType.values.toSet()
        : pillarsRaw
            .split(',')
            .where((s) => s.isNotEmpty)
            .map(PillarType.fromStorage)
            .toSet();

    return SettingsState(
      onboardingComplete: map[SettingsKeys.onboardingComplete] == 'true',
      dailyBudget: int.tryParse(map[SettingsKeys.dailyBudget] ?? '') ?? 5,
      reminderIntensity:
          ReminderIntensity.fromStorage(map[SettingsKeys.reminderIntensity]),
      enabledPillars: pillars,
    );
  }

  /// Persists the onboarding choices, applies the pillar selection to habits,
  /// and updates in-memory state so the app routes past onboarding.
  Future<void> completeOnboarding({
    required Set<PillarType> pillars,
    required int dailyBudget,
    required ReminderIntensity reminderIntensity,
  }) async {
    final settings = ref.read(settingsRepositoryProvider);
    await settings.setValue(SettingsKeys.dailyBudget, '$dailyBudget');
    await settings.setValue(
        SettingsKeys.reminderIntensity, reminderIntensity.storageKey);
    await settings.setValue(
        SettingsKeys.enabledPillars, pillars.map((p) => p.storageKey).join(','));
    await settings.setValue(SettingsKeys.onboardingComplete, 'true');

    // Focus the app: enable only the chosen pillars' habits.
    await ref.read(habitRepositoryProvider).setHabitsActiveForPillars(pillars);

    state = AsyncData(SettingsState(
      onboardingComplete: true,
      dailyBudget: dailyBudget,
      reminderIntensity: reminderIntensity,
      enabledPillars: pillars,
    ));
  }

  /// Updates the daily action budget (used later in Settings).
  Future<void> updateDailyBudget(int budget) async {
    await ref
        .read(settingsRepositoryProvider)
        .setValue(SettingsKeys.dailyBudget, '$budget');
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(dailyBudget: budget));
    }
  }

  Future<void> updateReminderIntensity(ReminderIntensity intensity) async {
    await ref
        .read(settingsRepositoryProvider)
        .setValue(SettingsKeys.reminderIntensity, intensity.storageKey);
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(reminderIntensity: intensity));
    }
  }

  /// Changes which pillars are active, persisting and re-applying to habits.
  Future<void> updateEnabledPillars(Set<PillarType> pillars) async {
    await ref.read(settingsRepositoryProvider).setValue(
        SettingsKeys.enabledPillars, pillars.map((p) => p.storageKey).join(','));
    await ref.read(habitRepositoryProvider).setHabitsActiveForPillars(pillars);
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(enabledPillars: pillars));
    }
  }
}

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, SettingsState>(
  SettingsController.new,
);
