import 'package:uuid/uuid.dart';

import '../entities/reflection.dart';
import '../repositories/reflection_repository.dart';

/// Saves today's reflection, generating its id and normalising the date. The
/// repository enforces one-per-day (replaces any existing entry for the day).
class SaveReflection {
  const SaveReflection(this._repository);

  final ReflectionRepository _repository;
  static const _uuid = Uuid();

  Future<void> call({
    required DateTime date,
    required Scale mood,
    required Scale energy,
    String? drained,
    String? energized,
    required DateTime now,
  }) {
    String? clean(String? s) => (s == null || s.trim().isEmpty) ? null : s.trim();

    return _repository.saveForDate(
      Reflection(
        id: _uuid.v4(),
        date: DateTime(date.year, date.month, date.day),
        mood: mood,
        energy: energy,
        drained: clean(drained),
        energized: clean(energized),
        createdAt: now,
      ),
    );
  }
}
