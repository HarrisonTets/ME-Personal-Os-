import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/reflection.dart' show Scale;
import '../finance/finance_controller.dart' show weekStartProvider;
import '../providers/app_providers.dart';
import '../reflection/scale_ui.dart';
import 'weekly_review_controller.dart';

/// The weekly check-in form (spec §6.1.4): alignment, how the body felt, and one
/// thing to change. Pre-fills with this week's reflection if it exists.
class WeeklyReflectionScreen extends ConsumerStatefulWidget {
  const WeeklyReflectionScreen({super.key});

  @override
  ConsumerState<WeeklyReflectionScreen> createState() =>
      _WeeklyReflectionScreenState();
}

class _WeeklyReflectionScreenState
    extends ConsumerState<WeeklyReflectionScreen> {
  final _changeController = TextEditingController();
  Scale? _alignment;
  Scale? _bodyFeel;
  bool _saving = false;
  bool _prefilled = false;

  @override
  void dispose() {
    _changeController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_alignment == null || _bodyFeel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Answer both questions first')),
      );
      return;
    }
    setState(() => _saving = true);
    await ref.read(saveWeeklyReflectionProvider)(
      weekStart: ref.read(weekStartProvider),
      alignment: _alignment!,
      bodyFeel: _bodyFeel!,
      oneChange: _changeController.text,
      now: DateTime.now(),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Weekly reflection saved 🌿')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Pre-fill from this week's saved reflection, if any.
    ref.watch(currentWeekReflectionProvider).whenData((r) {
      if (r != null && !_prefilled) {
        _prefilled = true;
        _alignment = r.alignment;
        _bodyFeel = r.bodyFeel;
        _changeController.text = r.oneChange ?? '';
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Weekly reflection')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          Text('Look back on your week',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _ScaleQuestion(
            question: 'How aligned did you feel this week?',
            selected: _alignment,
            onSelected: (s) => setState(() => _alignment = s),
          ),
          const SizedBox(height: 20),
          _ScaleQuestion(
            question: 'How did your body feel this week?',
            selected: _bodyFeel,
            onSelected: (s) => setState(() => _bodyFeel = s),
          ),
          const SizedBox(height: 24),
          Text('One thing to change next week',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: _changeController,
            minLines: 2,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Optional — one small, doable change',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 24),
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
              label: Text(_saving ? 'Saving…' : 'Save reflection'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleQuestion extends StatelessWidget {
  const _ScaleQuestion({
    required this.question,
    required this.selected,
    required this.onSelected,
  });
  final String question;
  final Scale? selected;
  final ValueChanged<Scale> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Row(
          children: [
            for (final s in Scale.values) ...[
              Expanded(
                child: _ScaleChip(
                  scale: s,
                  selected: selected == s,
                  onTap: () => onSelected(s),
                ),
              ),
              if (s != Scale.values.last) const SizedBox(width: 10),
            ],
          ],
        ),
      ],
    );
  }
}

class _ScaleChip extends StatelessWidget {
  const _ScaleChip({
    required this.scale,
    required this.selected,
    required this.onTap,
  });
  final Scale scale;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = scale.color;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? color : theme.dividerColor,
            width: selected ? 2 : 1,
          ),
          color: selected ? color.withValues(alpha: 0.12) : null,
        ),
        child: Center(
          child: Text(scale.label,
              style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
        ),
      ),
    );
  }
}
