import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/reflection.dart';
import '../providers/app_providers.dart';
import 'reflection_controller.dart';
import 'scale_ui.dart';

/// The evening daily-reflection flow (spec §6.1.4): mood + energy scales and two
/// open prompts. Pre-fills with today's reflection if one already exists (so it
/// doubles as "view / edit today's"), and lists recent reflections below.
class DailyReflectionScreen extends ConsumerStatefulWidget {
  const DailyReflectionScreen({super.key});

  @override
  ConsumerState<DailyReflectionScreen> createState() =>
      _DailyReflectionScreenState();
}

class _DailyReflectionScreenState
    extends ConsumerState<DailyReflectionScreen> {
  final _drainedController = TextEditingController();
  final _energizedController = TextEditingController();
  Scale? _mood;
  Scale? _energy;
  bool _saving = false;
  bool _prefilled = false;

  @override
  void dispose() {
    _drainedController.dispose();
    _energizedController.dispose();
    super.dispose();
  }

  /// Copy an existing reflection into the form the first time it loads.
  void _prefill(Reflection r) {
    if (_prefilled) return;
    _prefilled = true;
    _mood = r.mood;
    _energy = r.energy;
    _drainedController.text = r.drained ?? '';
    _energizedController.text = r.energized ?? '';
  }

  Future<void> _save() async {
    if (_mood == null || _energy == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick your mood and energy first')),
      );
      return;
    }
    setState(() => _saving = true);
    await ref.read(saveReflectionProvider)(
      date: ref.read(reflectionTodayProvider),
      mood: _mood!,
      energy: _energy!,
      drained: _drainedController.text,
      energized: _energizedController.text,
      now: DateTime.now(),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reflection saved 🌙')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Pre-fill from today's saved reflection, if any.
    ref.watch(todaysReflectionProvider).whenData((r) {
      if (r != null) _prefill(r);
    });
    final recent = ref.watch(recentReflectionsProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Evening reflection')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          Text('How are you, really?',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _ScalePicker(
            title: 'Mood',
            selected: _mood,
            emojiOf: (s) => s.moodEmoji,
            onSelected: (s) => setState(() => _mood = s),
          ),
          const SizedBox(height: 20),
          _ScalePicker(
            title: 'Energy',
            selected: _energy,
            emojiOf: (s) => s.energyEmoji,
            onSelected: (s) => setState(() => _energy = s),
          ),
          const SizedBox(height: 24),
          _PromptField(
            label: 'What drained you today?',
            controller: _drainedController,
          ),
          const SizedBox(height: 16),
          _PromptField(
            label: 'What energized you?',
            controller: _energizedController,
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
          if (recent.isNotEmpty) ...[
            const SizedBox(height: 32),
            Text('Past reflections',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final r in recent) _HistoryTile(reflection: r),
          ],
        ],
      ),
    );
  }
}

class _ScalePicker extends StatelessWidget {
  const _ScalePicker({
    required this.title,
    required this.selected,
    required this.emojiOf,
    required this.onSelected,
  });

  final String title;
  final Scale? selected;
  final String Function(Scale) emojiOf;
  final ValueChanged<Scale> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: theme.textTheme.labelLarge
                ?.copyWith(color: theme.hintColor)),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final s in Scale.values) ...[
              Expanded(
                child: _ScaleOption(
                  scale: s,
                  emoji: emojiOf(s),
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

class _ScaleOption extends StatelessWidget {
  const _ScaleOption({
    required this.scale,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  final Scale scale;
  final String emoji;
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
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 4),
            Text(scale.label,
                style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: selected ? FontWeight.bold : null)),
          ],
        ),
      ),
    );
  }
}

class _PromptField extends StatelessWidget {
  const _PromptField({required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 2,
      maxLines: 4,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.reflection});
  final Reflection reflection;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = reflection;
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
              children: [
                Text(DateFormat('EEE, MMM d').format(r.date),
                    style: theme.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('${r.mood.moodEmoji} ${r.energy.energyEmoji}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            if (r.energized != null) ...[
              const SizedBox(height: 6),
              Text('⚡ ${r.energized}', style: theme.textTheme.bodySmall),
            ],
            if (r.drained != null) ...[
              const SizedBox(height: 2),
              Text('🪫 ${r.drained}', style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
