import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/bible_plan.dart';
import '../../domain/entities/pillar.dart';
import '../providers/app_providers.dart';
import '../theme/pillar_ui.dart';

/// The Quiet Time flow for a single day's reading: shows the passage reference,
/// invites reflection, and on completion marks the reading done + saves the
/// reflection to the journal (via the [CompleteQuietTime] use case).
///
/// Stateful because it owns the reflection text field's controller.
class QuietTimeScreen extends ConsumerStatefulWidget {
  const QuietTimeScreen({super.key, required this.assignment});

  final ReadingAssignment assignment;

  @override
  ConsumerState<QuietTimeScreen> createState() => _QuietTimeScreenState();
}

class _QuietTimeScreenState extends ConsumerState<QuietTimeScreen> {
  final _reflectionController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    setState(() => _saving = true);
    final useCase = ref.read(completeQuietTimeProvider);
    await useCase(
      assignment: widget.assignment,
      reflection: _reflectionController.text,
      now: DateTime.now(),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.assignment.reference} complete 🙏')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = PillarType.spiritual.color;
    final reading = widget.assignment;

    return Scaffold(
      appBar: AppBar(title: Text(reading.reference)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Text('DAY ${reading.dayNumber}',
                style: theme.textTheme.labelMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8)),
            const SizedBox(height: 8),
            Text(reading.reference,
                style: theme.textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu_book, color: color),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Read ${reading.reference} in your Bible, slowly and '
                      'prayerfully. When you\'re ready, reflect below.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('What stood out to you?',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('Optional — even one sentence is enough.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.hintColor)),
            const SizedBox(height: 12),
            TextField(
              controller: _reflectionController,
              minLines: 4,
              maxLines: 8,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'A verse, a thought, a prayer…',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _saving ? null : _complete,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.check),
                label: Text(_saving ? 'Saving…' : 'Mark reading complete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
