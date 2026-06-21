/// How aggressively the app should remind the user (stored now, used once
/// notifications are built).
enum ReminderIntensity {
  low,
  medium,
  high;

  String get storageKey => name;
  static ReminderIntensity fromStorage(String? key) =>
      ReminderIntensity.values.firstWhere(
        (i) => i.name == key,
        orElse: () => ReminderIntensity.medium,
      );
}

/// The string keys used in the key-value settings store. Centralised so the
/// repository, controller and onboarding agree.
class SettingsKeys {
  const SettingsKeys._();

  static const onboardingComplete = 'onboarding_complete';
  static const dailyBudget = 'daily_budget';
  static const reminderIntensity = 'reminder_intensity';
  static const enabledPillars = 'enabled_pillars'; // comma-separated pillar keys
  static const userName = 'user_name';
  static const lifeMotto = 'life_motto';
}
