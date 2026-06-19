import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/journal_entry.dart';
import '../../domain/entities/pillar.dart';
import '../theme/pillar_ui.dart';
import 'bible_controller.dart';
import 'quiet_time_screen.dart';

/// Home of the Spiritual pillar: shows the active reading plan's progress,
/// today's reading with a "Begin Quiet Time" action, and the journal timeline.
class BibleHomeScreen extends ConsumerWidget {
  const BibleHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(bibleProgressProvider);
    final journal = ref.watch(journalProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Bible')),
      body: progress == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                _PlanCard(progress: progress),
                const SizedBox(height: 16),
                if (progress.isPlanComplete)
                  _PlanCompleteCard()
                else
                  _TodaysReadingCard(progress: progress),
                const SizedBox(height: 24),
                Text('Reflections',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (journal.isEmpty)
                  const _EmptyJournal()
                else
                  for (final entry in journal) _JournalTile(entry: entry),
              ],
            ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.progress});
  final BibleProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = PillarType.spiritual.color;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_stories, color: Colors.white),
              const SizedBox(width: 8),
              Text(progress.plan.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.fraction,
              minHeight: 8,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${progress.completed} of ${progress.total} days complete',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: Colors.white.withValues(alpha: 0.9)),
          ),
        ],
      ),
    );
  }
}

class _TodaysReadingCard extends StatelessWidget {
  const _TodaysReadingCard({required this.progress});
  final BibleProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reading = progress.todaysReading!;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TODAY · DAY ${reading.dayNumber}',
                style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6)),
            const SizedBox(height: 6),
            Text(reading.reference,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => QuietTimeScreen(assignment: reading),
                  ));
                },
                icon: const Icon(Icons.self_improvement),
                label: const Text('Begin Quiet Time'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCompleteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'You\'ve finished the plan. Beautifully done!',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _JournalTile extends StatelessWidget {
  const _JournalTile({required this.entry});
  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.reference,
                    style: theme.textTheme.labelLarge?.copyWith(
                        color: PillarType.spiritual.color,
                        fontWeight: FontWeight.w700)),
                Text(DateFormat('MMM d').format(entry.createdAt),
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.hintColor)),
              ],
            ),
            const SizedBox(height: 4),
            Text(entry.body, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _EmptyJournal extends StatelessWidget {
  const _EmptyJournal();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'No reflections yet. Your Quiet Time notes will appear here.',
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
      ),
    );
  }
}
