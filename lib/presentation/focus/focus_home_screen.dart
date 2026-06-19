import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/focus_session.dart';
import '../../domain/entities/pillar.dart';
import '../../domain/usecases/summarize_focus.dart';
import '../theme/pillar_ui.dart';
import 'focus_controller.dart';
import 'focus_session_screen.dart';

/// Home of the Focus pillar: start a deep-work session (intention + duration),
/// see today's totals, and review recent sessions.
class FocusHomeScreen extends ConsumerStatefulWidget {
  const FocusHomeScreen({super.key});

  @override
  ConsumerState<FocusHomeScreen> createState() => _FocusHomeScreenState();
}

class _FocusHomeScreenState extends ConsumerState<FocusHomeScreen> {
  final _intentionController = TextEditingController();
  int _minutes = 25;
  static const _durationOptions = [15, 25, 50];

  @override
  void dispose() {
    _intentionController.dispose();
    super.dispose();
  }

  void _start() {
    final intention = _intentionController.text.trim().isEmpty
        ? 'Deep work'
        : _intentionController.text.trim();
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => FocusSessionScreen(
        intention: intention,
        plannedMinutes: _minutes,
      ),
    ));
    _intentionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = ref.watch(todaysFocusSummaryProvider);
    final sessions = ref.watch(todaysSessionsProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Focus')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _StartCard(
            intentionController: _intentionController,
            minutes: _minutes,
            durationOptions: _durationOptions,
            onMinutes: (m) => setState(() => _minutes = m),
            onStart: _start,
          ),
          const SizedBox(height: 16),
          _TodayStats(summary: summary),
          const SizedBox(height: 24),
          Text('Today\'s sessions',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (sessions.isEmpty)
            _EmptyState(theme: theme)
          else
            for (final s in sessions) _SessionTile(session: s),
        ],
      ),
    );
  }
}

class _StartCard extends StatelessWidget {
  const _StartCard({
    required this.intentionController,
    required this.minutes,
    required this.durationOptions,
    required this.onMinutes,
    required this.onStart,
  });

  final TextEditingController intentionController;
  final int minutes;
  final List<int> durationOptions;
  final ValueChanged<int> onMinutes;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = PillarType.focus.color;

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
          Text('START A SESSION',
              style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8)),
          const SizedBox(height: 10),
          TextField(
            controller: intentionController,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'What will you focus on?',
              hintStyle: const TextStyle(color: Colors.white60),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final m in durationOptions) ...[
                _DurationChip(
                  minutes: m,
                  selected: m == minutes,
                  onTap: () => onMinutes(m),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: color,
              ),
              onPressed: onStart,
              icon: const Icon(Icons.play_arrow),
              label: Text('Start $minutes-min session'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.minutes,
    required this.selected,
    required this.onTap,
  });

  final int minutes;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$minutes min',
          style: TextStyle(
            color: selected ? PillarType.focus.color : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TodayStats extends StatelessWidget {
  const _TodayStats({required this.summary});
  final FocusSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _Stat(
                value: '${summary.totalFocusedMinutes}',
                unit: 'min',
                label: 'Focused today'),
            const SizedBox(width: 24),
            _Stat(
                value: '${summary.sessionCount}',
                unit: '',
                label: 'Sessions'),
            const SizedBox(width: 24),
            _Stat(
                value: '${summary.completedCount}',
                unit: '',
                label: 'Completed'),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.unit, required this.label});
  final String value;
  final String unit;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            if (unit.isNotEmpty)
              Text(' $unit',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.hintColor)),
          ],
        ),
        Text(label,
            style:
                theme.textTheme.labelSmall?.copyWith(color: theme.hintColor)),
      ],
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session});
  final FocusSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = PillarType.focus.color;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(
          session.completed ? Icons.check : Icons.timelapse,
          color: color,
          size: 18,
        ),
      ),
      title: Text(session.intention,
          maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(DateFormat('h:mm a').format(session.startedAt)),
      trailing: Text(
        '${session.focusedMinutes} min',
        style: theme.textTheme.titleSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(Icons.center_focus_strong_outlined,
              size: 40, color: theme.hintColor),
          const SizedBox(height: 8),
          Text('No sessions yet today.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.hintColor)),
          Text('Set an intention and start your first.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.hintColor)),
        ],
      ),
    );
  }
}
