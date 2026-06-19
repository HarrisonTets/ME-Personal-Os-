import 'pillar.dart';

/// Relative cognitive/physical load of a habit. Drives suggestion ranking —
/// e.g. lighter tasks are favoured on low-energy days.
enum HabitDifficulty {
  light,
  medium,
  deep;

  String get storageKey => name;

  static HabitDifficulty fromStorage(String key) =>
      HabitDifficulty.values.firstWhere((d) => d.name == key);
}

/// A recurring action the user wants to perform, linked to a single pillar.
///
/// For the current vertical slice every habit is treated as a daily habit;
/// richer scheduling (specific weekdays, weekly, custom) will be added later
/// without changing this entity's consumers.
class Habit {
  const Habit({
    required this.id,
    required this.name,
    required this.pillar,
    required this.difficulty,
    required this.estimatedMinutes,
    this.description,
    this.active = true,
    this.triggerKey,
  });

  final String id;
  final String name;
  final String? description;
  final PillarType pillar;
  final HabitDifficulty difficulty;
  final int estimatedMinutes;
  final bool active;

  /// Optional link to a pillar activity that auto-completes this habit. When the
  /// user performs that activity (e.g. finishes a Bible reading), any active
  /// habit with the matching [triggerKey] is marked done for the day. Null means
  /// the habit is only completed manually from the Today screen.
  final String? triggerKey;

  Habit copyWith({
    String? name,
    String? description,
    PillarType? pillar,
    HabitDifficulty? difficulty,
    int? estimatedMinutes,
    bool? active,
    String? triggerKey,
  }) {
    return Habit(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      pillar: pillar ?? this.pillar,
      difficulty: difficulty ?? this.difficulty,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      active: active ?? this.active,
      triggerKey: triggerKey ?? this.triggerKey,
    );
  }
}
