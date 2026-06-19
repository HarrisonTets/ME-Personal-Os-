import 'package:flutter/material.dart';

import '../../domain/entities/pillar.dart';

/// Presentation-only metadata for pillars (label, icon, colour). Lives here
/// rather than in the domain so the business layer stays UI-agnostic.
extension PillarUi on PillarType {
  String get label => switch (this) {
        PillarType.finance => 'Finance',
        PillarType.learning => 'Learning',
        PillarType.spiritual => 'Spiritual',
        PillarType.focus => 'Focus',
        PillarType.health => 'Health',
      };

  IconData get icon => switch (this) {
        PillarType.finance => Icons.account_balance_wallet_outlined,
        PillarType.learning => Icons.menu_book_outlined,
        PillarType.spiritual => Icons.auto_stories_outlined,
        PillarType.focus => Icons.center_focus_strong_outlined,
        PillarType.health => Icons.favorite_outline,
      };

  Color get color => switch (this) {
        PillarType.finance => const Color(0xFF2E7D5B),
        PillarType.learning => const Color(0xFF3D5AFE),
        PillarType.spiritual => const Color(0xFF8E44AD),
        PillarType.focus => const Color(0xFFE67E22),
        PillarType.health => const Color(0xFFE53E5A),
      };
}
