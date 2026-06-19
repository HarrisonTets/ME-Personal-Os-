import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'today_controller.dart';
import 'widgets/suggestion_card.dart';

/// The single home screen: a small, prioritised set of actions for today across
/// all pillars, with progress feedback. This is the vertical slice that proves
/// the Presentation → Domain → Data wiring end-to-end.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncSuggestions = ref.watch(todayControllerProvider);
    final controller = ref.read(todayControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: asyncSuggestions.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _ErrorView(
            message: '$e',
            onRetry: controller.regenerate,
          ),
          data: (suggestions) {
            final outstanding =
                suggestions.where((s) => !s.completedToday).toList();
            final done =
                suggestions.where((s) => s.completedToday).toList();

            return RefreshIndicator(
              onRefresh: controller.regenerate,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                children: [
                  _Header(doneCount: done.length, total: suggestions.length),
                  const SizedBox(height: 16),
                  if (outstanding.isEmpty && done.isNotEmpty)
                    _AllDoneBanner(theme: theme)
                  else
                    _SectionLabel('Suggested for today', theme: theme),
                  for (final s in outstanding)
                    SuggestionCard(
                      suggestion: s,
                      onToggle: () => controller.toggleDone(s),
                    ),
                  if (done.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _SectionLabel('Completed', theme: theme),
                    for (final s in done)
                      SuggestionCard(
                        suggestion: s,
                        onToggle: () => controller.toggleDone(s),
                      ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.doneCount, required this.total});

  final int doneCount;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final progress = total == 0 ? 0.0 : doneCount / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE, MMM d').format(now),
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
        ),
        const SizedBox(height: 2),
        Text('Today', style: theme.textTheme.headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: theme.dividerColor.withValues(alpha: 0.3),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          total == 0
              ? 'No habits yet'
              : '$doneCount of $total done',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {required this.theme});
  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Text(
        text,
        style: theme.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.w700, color: theme.hintColor),
      ),
    );
  }
}

class _AllDoneBanner extends StatelessWidget {
  const _AllDoneBanner({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'All of today\'s suggestions are done. Well done!',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
