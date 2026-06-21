/// A simple key-value settings store (strings only — callers parse as needed).
abstract interface class SettingsRepository {
  /// All stored settings as a key→value map.
  Future<Map<String, String>> getAll();

  /// Writes a single setting, replacing any existing value for [key].
  Future<void> setValue(String key, String value);
}
