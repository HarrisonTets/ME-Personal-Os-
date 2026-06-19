import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../domain/entities/finance_entry.dart';
import '../providers/app_providers.dart';

/// A bottom sheet to log an income/expense in a few taps. Opened from the
/// Finance home screen. Stateful because it holds the in-progress form values.
class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({super.key});

  /// Convenience helper to show the sheet (handles keyboard padding + shape).
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const QuickAddSheet(),
    );
  }

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  FinanceType _type = FinanceType.expense;
  FinanceCategory _category = FinanceCategory.food;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      setState(() => _error = 'Enter an amount greater than 0');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    await ref.read(addFinanceEntryProvider)(
      type: _type,
      amount: amount,
      category: _category,
      date: DateTime.now(),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );

    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved ${formatMoney(amount)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Pad the bottom by the keyboard height so fields stay visible.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick add',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          // Income / Expense toggle
          SegmentedButton<FinanceType>(
            segments: const [
              ButtonSegment(
                  value: FinanceType.expense,
                  label: Text('Expense'),
                  icon: Icon(Icons.arrow_upward)),
              ButtonSegment(
                  value: FinanceType.income,
                  label: Text('Income'),
                  icon: Icon(Icons.arrow_downward)),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: 16),

          // Amount
          TextField(
            controller: _amountController,
            autofocus: true,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            decoration: InputDecoration(
              labelText: 'Amount',
              prefixText: '$kCurrencySymbol ',
              border: const OutlineInputBorder(),
              errorText: _error,
            ),
          ),
          const SizedBox(height: 16),

          // Category chips
          Text('Category',
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: theme.hintColor)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final c in FinanceCategory.values)
                ChoiceChip(
                  label: Text(c.label),
                  selected: _category == c,
                  onSelected: (_) => setState(() => _category = c),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Optional note
          TextField(
            controller: _noteController,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Note (optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.check),
              label: Text(_saving ? 'Saving…' : 'Save'),
            ),
          ),
        ],
      ),
    );
  }
}
