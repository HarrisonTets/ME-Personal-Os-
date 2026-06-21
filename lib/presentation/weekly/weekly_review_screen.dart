import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/money.dart';
import '../../domain/entities/pillar.dart';
import '../reflection/scale_ui.dart';
import '../today/widgets/today_insights.dart';
import '../theme/pillar_ui.dart';
import 'weekly_reflection_screen.dart';
import 'weekly_review_controller.dart';

/// A single screen that summarises the week across every pillar — the "step back
/// and see the whole picture" moment that sets ME apart from single-purpose apps.
class WeeklyReviewScreen extends ConsumerWidget {
  const WeeklyReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncSummary = ref.watch(weeklyReviewProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weekly review')),
      body: asyncSummary.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (s) {
          final end = s.weekStart.add(const Duration(days: 6));
          final topPillar = _topPillar(s);
          final weakPillar = _weakPillar(s);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              Text(
                '${DateFormat('MMM d').format(s.weekStart)} – '
                '${DateFormat('MMM d').format(end)}',
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
              ),
              const SizedBox(height: 2),
              Text('Your week',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Reuse the same pillar balance strip from Today.
              const PillarScoresStrip(),
              const SizedBox(height: 20),

              // Key numbers across pillars.
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _StatCard(
                    icon: Icons.check_circle_outline,
                    color: PillarType.health.color,
                    value: '${s.habitsCompleted}',
                    label: 'Actions completed',
                  ),
                  _StatCard(
                    icon: Icons.center_focus_strong_outlined,
                    color: PillarType.focus.color,
                    value: '${s.focusMinutes}',
                    label: 'Minutes focused',
                  ),
                  _StatCard(
                    icon: Icons.account_balance_wallet_outlined,
                    color: PillarType.finance.color,
                    value: formatMoney(s.spent),
                    label: 'Spent',
                  ),
                  _StatCard(
                    icon: Icons.auto_stories_outlined,
                    color: PillarType.spiritual.color,
                    value: '${s.bibleReadings}',
                    label: 'Readings done',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (topPillar != null || weakPillar != null)
                _InsightCard(top: topPillar, weak: weakPillar),
              const SizedBox(height: 16),
              const _WeeklyReflectionCard(),
            ],
          );
        },
      ),
    );
  }

  PillarType? _topPillar(WeeklySummary s) {
    if (s.pillarScores.isEmpty) return null;
    final sorted = [...s.pillarScores]
      ..sort((a, b) => b.score.compareTo(a.score));
    return sorted.first.score > 0 ? sorted.first.pillar : null;
  }

  PillarType? _weakPillar(WeeklySummary s) {
    if (s.pillarScores.length < 2) return null;
    final sorted = [...s.pillarScores]
      ..sort((a, b) => a.score.compareTo(b.score));
    return sorted.first.pillar;
  }
}

/// Shows this week's reflection if written, otherwise invites the user to do it.
/// Tapping opens the weekly reflection form.
class _WeeklyReflectionCard extends ConsumerWidget {
  const _WeeklyReflectionCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reflection = ref.watch(currentWeekReflectionProvider).value;
    final done = reflection != null;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const WeeklyReflectionScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Text(done ? '🌿' : '🪞', style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(done ? 'Weekly reflection' : 'Reflect on your week',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(
                    done
                        ? 'Aligned: ${reflection.alignment.label} · '
                            'Body: ${reflection.bodyFeel.label} — tap to edit'
                        : 'A few questions to close the week well.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.hintColor),
                  ),
                ],
              ),
            ),
            Icon(done ? Icons.check_circle : Icons.chevron_right,
                color: done ? theme.colorScheme.primary : theme.hintColor),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text(label,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.hintColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.top, required this.weak});
  final PillarType? top;
  final PillarType? weak;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Looking ahead',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (top != null)
            _line(context, '🌟', 'Strongest this week: ${top!.label}.'),
          if (weak != null)
            _line(context, '🌱',
                'A little love for ${weak!.label} next week could help.'),
        ],
      ),
    );
  }

  Widget _line(BuildContext context, String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
