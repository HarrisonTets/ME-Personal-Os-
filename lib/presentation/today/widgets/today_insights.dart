import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/pillar.dart';
import '../../../domain/entities/reflection.dart';
import '../../shell/home_shell.dart';
import '../../theme/pillar_ui.dart';
import '../today_controller.dart';

/// A horizontal strip of pillar "health" scores (0–100). Makes the cross-pillar
/// balance visible at a glance — weak areas stand out, which is the whole point
/// of ME versus a single-purpose tracker.
class PillarScoresStrip extends ConsumerWidget {
  const PillarScoresStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scores = ref.watch(pillarScoresProvider).value ?? const [];
    if (scores.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10),
            child: Text('YOUR PILLARS',
                style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final s in scores)
                _PillarRing(
                  pillar: s.pillar,
                  score: s.score,
                  onTap: () {
                    final tab = pillarTabIndex[s.pillar.storageKey];
                    if (tab != null) {
                      ref.read(homeTabProvider.notifier).select(tab);
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PillarRing extends StatelessWidget {
  const _PillarRing({
    required this.pillar,
    required this.score,
    required this.onTap,
  });
  final PillarType pillar;
  final int score;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = pillar.color;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          children: [
            SizedBox(
              width: 46,
              height: 46,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 46,
                    height: 46,
                    child: CircularProgressIndicator(
                      value: score / 100,
                      strokeWidth: 4,
                      backgroundColor: color.withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                  Icon(pillar.icon, color: color, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text('$score',
                style: theme.textTheme.labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text(pillar.label,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: theme.hintColor)),
          ],
        ),
      ),
    );
  }
}

/// A banner that explains how today's list was shaped by the user's reflected
/// energy — making the reflection → suggestion link visible. Hidden on
/// medium-energy days to avoid clutter.
class DayShapeBanner extends ConsumerWidget {
  const DayShapeBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final energy = ref.watch(dayEnergyProvider);
    if (energy == Scale.medium) return const SizedBox.shrink();

    final (icon, color, text) = switch (energy) {
      Scale.low => (
          Icons.spa_outlined,
          const Color(0xFF66BB6A),
          'Gentle day — you logged low energy, so lighter actions come first.',
        ),
      Scale.high => (
          Icons.bolt,
          const Color(0xFFE67E22),
          'Big day — high energy, so the deeper work is up top.',
        ),
      Scale.medium => (Icons.balance, theme.hintColor, ''),
    };

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
