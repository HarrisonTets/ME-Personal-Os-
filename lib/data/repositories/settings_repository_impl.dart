import '../../domain/repositories/settings_repository.dart';
import '../local/app_database.dart';

/// Drift-backed key-value [SettingsRepository].
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Map<String, String>> getAll() async {
    final rows = await _db.select(_db.settings).get();
    return {for (final r in rows) r.key: r.value};
  }

  @override
  Future<void> setValue(String key, String value) {
    // Upsert: insert or replace on the primary key.
    return _db.into(_db.settings).insertOnConflictUpdate(
          SettingsCompanion.insert(key: key, value: value),
        );
  }
}
