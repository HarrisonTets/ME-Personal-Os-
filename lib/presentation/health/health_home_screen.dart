import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/health_log.dart';
import '../../domain/entities/pillar.dart';
import '../providers/app_providers.dart';
import '../theme/pillar_ui.dart';
import 'health_controller.dart';
import 'health_ui.dart';

/// Home of the Health pillar: tap a card to log water/walk/workout/sleep, see
/// today's progress toward simple targets, and review/undo today's logs.
class HealthHomeScreen extends ConsumerWidget {
  const HealthHomeScreen({super.key});

  /// The four activities surfaced as cards on the home screen.
  static const _cards = [
    HealthLogType.water,
    HealthLogType.walk,
    HealthLogType.workout,
    HealthLogType.sleep,
  ];

  Future<void> _log(
    BuildContext context,
    WidgetRef ref,
    HealthLogType type,
  ) async {
    final quick = type.quickAddAmount;
    final value = quick ?? await _askForValue(context, type);
    if (value == null || value <= 0) return;

    await ref.read(addHealthLogProvider)(
      type: type,
      value: value,
      date: DateTime.now(),
    );
    if (context.mounted && quick != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(
              'Added ${type.formatValue(value)} ${type.unit} · ${type.label}'),
        ),
      );
    }
  }

  /// Number-entry dialog for activities that need a value (workout, sleep).
  Future<double?> _askForValue(BuildContext context, HealthLogType type) {
    final controller = TextEditingController();
    final prompt = type == HealthLogType.sleep
        ? 'How many hours did you sleep?'
        : 'How many minutes?';
    return showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(type.label),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          decoration: InputDecoration(
            labelText: prompt,
            suffixText: type.unit,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, double.tryParse(controller.text.trim())),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final summary = ref.watch(todaysHealthSummaryProvider);
    final logs = ref.watch(todaysHealthLogsProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Health')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Text('Today\'s wellness',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: [
              for (final type in _cards)
                _MetricCard(
                  type: type,
                  total: summary.of(type),
                  onTap: () => _log(context, ref, type),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Today\'s log',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (logs.isEmpty)
            _EmptyState(theme: theme)
          else
            for (final log in logs)
              _LogTile(
                log: log,
                onDelete: () =>
                    ref.read(healthRepositoryProvider).deleteLog(log.id),
              ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.type,
    required this.total,
    required this.onTap,
  });

  final HealthLogType type;
  final double total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = PillarType.health.color;
    final target = type.dailyTarget;
    final fraction = target == 0 ? 0.0 : (total / target).clamp(0.0, 1.0);
    final reached = total >= target;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.dividerColor),
          color: reached ? color.withValues(alpha: 0.08) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(type.icon, color: color, size: 20),
                const SizedBox(width: 6),
                Text(type.label,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const Spacer(),
                if (reached) Icon(Icons.check_circle, color: color, size: 18),
              ],
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: type.formatValue(total)),
                  TextSpan(
                    text: ' / ${type.formatValue(target)} ${type.unit}',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.hintColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 6,
                backgroundColor: theme.dividerColor.withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.add, size: 14, color: color),
                Text(
                  type.quickAddAmount != null
                      ? 'Tap to add ${type.formatValue(type.quickAddAmount!)}'
                      : 'Tap to log',
                  style: theme.textTheme.labelSmall?.copyWith(color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LogTile extends StatelessWidget {
  const _LogTile({required this.log, required this.onDelete});
  final HealthLog log;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final color = PillarType.health.color;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(log.type.icon, color: color, size: 18),
      ),
      title: Text(log.type.label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${log.type.formatValue(log.value)} ${log.type.unit}',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            tooltip: 'Remove',
            onPressed: onDelete,
          ),
        ],
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
          Icon(Icons.favorite_outline, size: 40, color: theme.hintColor),
          const SizedBox(height: 8),
          Text('Nothing logged yet today.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.hintColor)),
          Text('Tap a card above to start.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.hintColor)),
        ],
      ),
    );
  }
}
