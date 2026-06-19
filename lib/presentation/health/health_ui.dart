import 'package:flutter/material.dart';

import '../../domain/entities/health_log.dart';

/// Presentation-only metadata for each health activity: how to label it, its
/// unit, icon, sensible daily target, and how the user adds to it.
extension HealthUi on HealthLogType {
  String get label => switch (this) {
        HealthLogType.water => 'Water',
        HealthLogType.walk => 'Walk',
        HealthLogType.workout => 'Workout',
        HealthLogType.sleep => 'Sleep',
        HealthLogType.stretch => 'Stretch',
      };

  String get unit => switch (this) {
        HealthLogType.water => 'glasses',
        HealthLogType.walk => 'min',
        HealthLogType.workout => 'min',
        HealthLogType.sleep => 'h',
        HealthLogType.stretch => 'min',
      };

  IconData get icon => switch (this) {
        HealthLogType.water => Icons.water_drop_outlined,
        HealthLogType.walk => Icons.directions_walk,
        HealthLogType.workout => Icons.fitness_center,
        HealthLogType.sleep => Icons.bedtime_outlined,
        HealthLogType.stretch => Icons.self_improvement,
      };

  /// A reasonable default daily goal (configurable as a user setting later).
  double get dailyTarget => switch (this) {
        HealthLogType.water => 8,
        HealthLogType.walk => 30,
        HealthLogType.workout => 30,
        HealthLogType.sleep => 8,
        HealthLogType.stretch => 10,
      };

  /// For one-tap activities, the amount added per tap. Null means "ask the user
  /// for a value" (e.g. sleep hours, workout minutes).
  double? get quickAddAmount => switch (this) {
        HealthLogType.water => 1,
        HealthLogType.walk => 10,
        HealthLogType.stretch => 5,
        HealthLogType.workout => null,
        HealthLogType.sleep => null,
      };

  /// Formats a value without trailing ".0" for whole numbers (e.g. 8, 7.5).
  String formatValue(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}
