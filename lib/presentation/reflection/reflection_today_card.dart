import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'daily_reflection_screen.dart';
import 'reflection_controller.dart';
import 'scale_ui.dart';

/// A Today-screen entry point for the evening reflection. Shows an invitation if
/// today's reflection isn't done yet, or a summary (with mood/energy) if it is.
/// Tapping opens the reflection flow.
class ReflectionTodayCard extends ConsumerWidget {
  const ReflectionTodayCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reflection = ref.watch(todaysReflectionProvider).value;
    final done = reflection != null;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: CircleAvatar(
          backgroundColor:
              theme.colorScheme.primary.withValues(alpha: 0.12),
          child: Text(
            done ? reflection.mood.moodEmoji : '🌙',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        title: Text(done ? 'Reflection done' : 'Evening reflection',
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          done
              ? 'Mood ${reflection.mood.label} · Energy ${reflection.energy.label} — tap to edit'
              : 'How did today feel? Take a moment.',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
        ),
        trailing: Icon(done ? Icons.check_circle : Icons.chevron_right,
            color: done ? theme.colorScheme.primary : theme.hintColor),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const DailyReflectionScreen()),
        ),
      ),
    );
  }
}
