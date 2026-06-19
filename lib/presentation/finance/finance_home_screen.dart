import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/money.dart';
import '../../domain/entities/finance_entry.dart';
import '../../domain/entities/pillar.dart';
import '../../domain/usecases/summarize_spending.dart';
import '../theme/pillar_ui.dart';
import 'finance_controller.dart';
import 'quick_add_sheet.dart';

/// Home of the Finance pillar: this week's totals, top spending categories, and
/// a recent-entries list. A button opens the Quick-Add sheet.
class FinanceHomeScreen extends ConsumerWidget {
  const FinanceHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(weeklySummaryProvider);
    final entries = ref.watch(weeklyEntriesProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Finance')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => QuickAddSheet.show(context),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          _WeekCard(summary: summary),
          if (summary.topCategories.isNotEmpty) ...[
            const SizedBox(height: 16),
            _TopCategories(summary: summary),
          ],
          const SizedBox(height: 24),
          Text('This week\'s entries',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (entries.isEmpty)
            const _EmptyState()
          else
            for (final e in entries) _EntryTile(entry: e),
        ],
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({required this.summary});
  final SpendingSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = PillarType.finance.color;

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
          Text('THIS WEEK',
              style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8)),
          const SizedBox(height: 6),
          Text(formatMoney(summary.totalExpense),
              style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Text('spent',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: Colors.white70)),
          const SizedBox(height: 14),
          Row(
            children: [
              _MiniStat(
                  label: 'Income',
                  value: formatMoney(summary.totalIncome)),
              const SizedBox(width: 20),
              _MiniStat(label: 'Entries', value: '${summary.entryCount}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white, fontWeight: FontWeight.w600)),
        Text(label,
            style:
                theme.textTheme.labelSmall?.copyWith(color: Colors.white70)),
      ],
    );
  }
}

class _TopCategories extends StatelessWidget {
  const _TopCategories({required this.summary});
  final SpendingSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final max = summary.topCategories.first.total;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top categories',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (final c in summary.topCategories) ...[
              Row(
                children: [
                  Expanded(child: Text(c.category.label)),
                  Text(formatMoney(c.total),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: max == 0 ? 0 : c.total / max,
                  minHeight: 6,
                  backgroundColor: theme.dividerColor.withValues(alpha: 0.3),
                  valueColor:
                      AlwaysStoppedAnimation(PillarType.finance.color),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({required this.entry});
  final FinanceEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpense = entry.type == FinanceType.expense;
    final sign = isExpense ? '-' : '+';
    final amountColor =
        isExpense ? theme.colorScheme.error : PillarType.finance.color;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: CircleAvatar(
        backgroundColor: PillarType.finance.color.withValues(alpha: 0.12),
        child: Icon(
          isExpense ? Icons.arrow_upward : Icons.arrow_downward,
          color: PillarType.finance.color,
          size: 18,
        ),
      ),
      title: Text(entry.category.label),
      subtitle: Text(
        '${DateFormat('EEE, MMM d').format(entry.date)}'
        '${entry.note != null ? ' · ${entry.note}' : ''}',
      ),
      trailing: Text(
        '$sign${formatMoney(entry.amount)}',
        style: theme.textTheme.titleMedium
            ?.copyWith(color: amountColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(Icons.receipt_long_outlined, size: 40, color: theme.hintColor),
          const SizedBox(height: 8),
          Text('No entries yet this week.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.hintColor)),
          Text('Tap “Add” to log your first one.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.hintColor)),
        ],
      ),
    );
  }
}
