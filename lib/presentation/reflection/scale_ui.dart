import 'package:flutter/material.dart';

import '../../domain/entities/reflection.dart';

/// Presentation metadata for the low/medium/high [Scale].
extension ScaleUi on Scale {
  String get label => switch (this) {
        Scale.low => 'Low',
        Scale.medium => 'Medium',
        Scale.high => 'High',
      };

  String get moodEmoji => switch (this) {
        Scale.low => '😔',
        Scale.medium => '😐',
        Scale.high => '😊',
      };

  String get energyEmoji => switch (this) {
        Scale.low => '🪫',
        Scale.medium => '🔋',
        Scale.high => '⚡',
      };

  Color get color => switch (this) {
        Scale.low => const Color(0xFFE57373),
        Scale.medium => const Color(0xFFFFB74D),
        Scale.high => const Color(0xFF66BB6A),
      };
}
