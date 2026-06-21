import 'package:uuid/uuid.dart';

import '../entities/reflection.dart' show Scale;
import '../entities/weekly_reflection.dart';
import '../repositories/weekly_reflection_repository.dart';

/// Saves the weekly reflection, generating its id and normalising the week key.
class SaveWeeklyReflection {
  const SaveWeeklyReflection(this._repository);

  final WeeklyReflectionRepository _repository;
  static const _uuid = Uuid();

  Future<void> call({
    required DateTime weekStart,
    required Scale alignment,
    required Scale bodyFeel,
    String? oneChange,
    required DateTime now,
  }) {
    final change =
        (oneChange == null || oneChange.trim().isEmpty) ? null : oneChange.trim();
    return _repository.saveForWeek(
      WeeklyReflection(
        id: _uuid.v4(),
        weekStart: DateTime(weekStart.year, weekStart.month, weekStart.day),
        alignment: alignment,
        bodyFeel: bodyFeel,
        oneChange: change,
        createdAt: now,
      ),
    );
  }
}
