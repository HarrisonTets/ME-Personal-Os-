import 'package:flutter/material.dart';

import '../../../domain/entities/suggestion.dart';
import '../../theme/pillar_ui.dart';

/// A single Today action: pillar identity, the habit, why it's suggested, time
/// estimate, and a one-tap done toggle.
class SuggestionCard extends StatelessWidget {
  const SuggestionCard({
    super.key,
    required this.suggestion,
    required this.onToggle,
  });

  final Suggestion suggestion;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pillar = suggestion.habit.pillar;
    final done = suggestion.completedToday;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: pillar.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(pillar.icon, color: pillar.color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          pillar.label.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: pillar.color,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.schedule,
                            size: 13, color: theme.hintColor),
                        const SizedBox(width: 3),
                        Text(
                          '${suggestion.habit.estimatedMinutes} min',
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: theme.hintColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      suggestion.habit.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration:
                            done ? TextDecoration.lineThrough : null,
                        color: done ? theme.hintColor : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      suggestion.reason,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.hintColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _DoneButton(done: done, color: pillar.color, onTap: onToggle),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({
    required this.done,
    required this.color,
    required this.onTap,
  });

  final bool done;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: done ? 'Mark not done' : 'Mark done',
      icon: Icon(
        done ? Icons.check_circle : Icons.radio_button_unchecked,
        color: done ? color : Theme.of(context).hintColor,
        size: 28,
      ),
    );
  }
}
