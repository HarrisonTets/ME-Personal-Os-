import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/entities/pillar.dart';
import '../theme/pillar_ui.dart';
import 'settings_controller.dart';

/// Lets the user revisit the choices made during onboarding: which pillars are
/// active, the daily action budget, and reminder intensity. Each change saves
/// immediately.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSettings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: asyncSettings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (settings) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _SectionHeader('Profile'),
            _SectionHint('A personal touch shown on your Today screen.'),
            const SizedBox(height: 8),
            _ProfileEditor(
              key: ValueKey('${settings.userName}|${settings.lifeMotto}'),
              initialName: settings.userName ?? '',
              initialMotto: settings.lifeMotto ?? '',
              onSave: (name, motto) =>
                  controller.updateProfile(name: name, motto: motto),
            ),
            const SizedBox(height: 24),
            _SectionHeader('Focus pillars'),
            _SectionHint('The areas ME suggests actions from.'),
            const SizedBox(height: 4),
            for (final pillar in PillarType.values)
              _PillarSwitch(
                pillar: pillar,
                enabled: settings.enabledPillars.contains(pillar),
                onChanged: (on) =>
                    _togglePillar(context, controller, settings, pillar, on),
              ),
            const SizedBox(height: 24),
            _SectionHeader('Daily actions'),
            _SectionHint('How many suggestions Today shows at most.'),
            const SizedBox(height: 8),
            Row(
              children: [
                for (final n in const [3, 4, 5]) ...[
                  Expanded(
                    child: _PillButton(
                      label: '$n',
                      selected: settings.dailyBudget == n,
                      onTap: () => controller.updateDailyBudget(n),
                    ),
                  ),
                  if (n != 5) const SizedBox(width: 10),
                ],
              ],
            ),
            const SizedBox(height: 24),
            _SectionHeader('Reminder intensity'),
            _SectionHint('How much ME nudges you. (Reminders arrive later.)'),
            const SizedBox(height: 8),
            RadioGroup<ReminderIntensity>(
              groupValue: settings.reminderIntensity,
              onChanged: (v) {
                if (v != null) controller.updateReminderIntensity(v);
              },
              child: Column(
                children: [
                  for (final i in ReminderIntensity.values)
                    RadioListTile<ReminderIntensity>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_intensityLabel(i)),
                      value: i,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Toggle a pillar, but never let the user disable the last remaining one.
  void _togglePillar(
    BuildContext context,
    SettingsController controller,
    SettingsState settings,
    PillarType pillar,
    bool on,
  ) {
    final next = Set<PillarType>.from(settings.enabledPillars);
    on ? next.add(pillar) : next.remove(pillar);
    if (next.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keep at least one pillar active')),
      );
      return;
    }
    controller.updateEnabledPillars(next);
  }

  String _intensityLabel(ReminderIntensity i) => switch (i) {
        ReminderIntensity.low => 'Low',
        ReminderIntensity.medium => 'Medium',
        ReminderIntensity.high => 'High',
      };
}

/// Editable name + life-motto fields with a Save button. Stateful so it owns the
/// text controllers; re-created (via key) when the underlying settings change.
class _ProfileEditor extends StatefulWidget {
  const _ProfileEditor({
    super.key,
    required this.initialName,
    required this.initialMotto,
    required this.onSave,
  });

  final String initialName;
  final String initialMotto;
  final void Function(String name, String motto) onSave;

  @override
  State<_ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<_ProfileEditor> {
  late final _nameController = TextEditingController(text: widget.initialName);
  late final _mottoController = TextEditingController(text: widget.initialMotto);

  @override
  void dispose() {
    _nameController.dispose();
    _mottoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Your name',
            hintText: 'What should we call you?',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _mottoController,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Life motto',
            hintText: 'A phrase to ground your day',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.tonal(
            onPressed: () {
              widget.onSave(_nameController.text, _mottoController.text);
              FocusScope.of(context).unfocus();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile saved')),
              );
            },
            child: const Text('Save profile'),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

class _SectionHint extends StatelessWidget {
  const _SectionHint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(text,
        style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor));
  }
}

class _PillarSwitch extends StatelessWidget {
  const _PillarSwitch({
    required this.pillar,
    required this.enabled,
    required this.onChanged,
  });
  final PillarType pillar;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: CircleAvatar(
        backgroundColor: pillar.color.withValues(alpha: 0.14),
        child: Icon(pillar.icon, color: pillar.color, size: 20),
      ),
      title: Text(pillar.label),
      value: enabled,
      onChanged: onChanged,
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? color : theme.dividerColor,
            width: selected ? 2 : 1,
          ),
          color: selected ? color.withValues(alpha: 0.10) : null,
        ),
        child: Text(label,
            style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: selected ? color : null)),
      ),
    );
  }
}
