import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/entities/pillar.dart';
import '../settings/settings_controller.dart';
import '../theme/pillar_ui.dart';

/// First-run setup (spec §6.1.1): pick the pillars to focus on, a daily action
/// budget, and reminder intensity. On finish it persists the choices and focuses
/// the app on the chosen pillars.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  // Choices (sensible defaults).
  final Set<PillarType> _pillars = PillarType.values.toSet();
  int _dailyBudget = 5;
  ReminderIntensity _intensity = ReminderIntensity.medium;
  bool _saving = false;

  static const _lastPage = 3;

  void _next() {
    if (_page < _lastPage) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    if (_pillars.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one pillar')),
      );
      return;
    }
    setState(() => _saving = true);
    await ref.read(settingsControllerProvider.notifier).completeOnboarding(
          pillars: _pillars,
          dailyBudget: _dailyBudget,
          reminderIntensity: _intensity,
        );
    // The root gate (watching settings) swaps to HomeShell automatically.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _page != 1 || _pillars.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _ProgressDots(count: _lastPage + 1, current: _page),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  const _WelcomePage(),
                  _PillarsPage(
                    selected: _pillars,
                    onToggle: (p) => setState(() {
                      if (!_pillars.remove(p)) _pillars.add(p);
                    }),
                  ),
                  _BudgetPage(
                    value: _dailyBudget,
                    onChanged: (v) => setState(() => _dailyBudget = v),
                  ),
                  _IntensityPage(
                    value: _intensity,
                    onChanged: (v) => setState(() => _intensity = v),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: (!canContinue || _saving) ? null : _next,
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Text(_page == _lastPage ? 'Get started' : 'Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.count, required this.current});
  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == current ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == current ? color : color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}

/// Shared page scaffold: a big title, a subtitle, and content below.
class _Page extends StatelessWidget {
  const _Page({required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(title,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.hintColor)),
          const SizedBox(height: 28),
          child,
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🌱', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 20),
          Text('Welcome to ME',
              style: theme.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            'Your personal growth companion. A few quick questions and we\'ll '
            'tailor each day to you — a small set of meaningful actions instead '
            'of an endless to-do list.',
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.hintColor, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _PillarsPage extends StatelessWidget {
  const _PillarsPage({required this.selected, required this.onToggle});
  final Set<PillarType> selected;
  final ValueChanged<PillarType> onToggle;

  @override
  Widget build(BuildContext context) {
    return _Page(
      title: 'What matters to you?',
      subtitle: 'Pick the areas you want to grow in. You can change this later.',
      child: Column(
        children: [
          for (final p in PillarType.values)
            _PillarTile(
              pillar: p,
              selected: selected.contains(p),
              onTap: () => onToggle(p),
            ),
        ],
      ),
    );
  }
}

class _PillarTile extends StatelessWidget {
  const _PillarTile({
    required this.pillar,
    required this.selected,
    required this.onTap,
  });
  final PillarType pillar;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? pillar.color : theme.dividerColor,
              width: selected ? 2 : 1,
            ),
            color: selected ? pillar.color.withValues(alpha: 0.08) : null,
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: pillar.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(pillar.icon, color: pillar.color),
              ),
              const SizedBox(width: 14),
              Text(pillar.label,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? pillar.color : theme.hintColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BudgetPage extends StatelessWidget {
  const _BudgetPage({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return _Page(
      title: 'How many actions a day?',
      subtitle: 'We\'ll suggest at most this many, to keep things focused.',
      child: Column(
        children: [
          for (final n in const [3, 4, 5])
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ChoiceRow(
                label: '$n actions per day',
                hint: switch (n) {
                  3 => 'Gentle — just the essentials',
                  4 => 'Balanced',
                  _ => 'Ambitious',
                },
                selected: value == n,
                onTap: () => onChanged(n),
              ),
            ),
        ],
      ),
    );
  }
}

class _IntensityPage extends StatelessWidget {
  const _IntensityPage({required this.value, required this.onChanged});
  final ReminderIntensity value;
  final ValueChanged<ReminderIntensity> onChanged;

  @override
  Widget build(BuildContext context) {
    return _Page(
      title: 'Reminder intensity',
      subtitle: 'How much should the app nudge you? (Reminders arrive later.)',
      child: Column(
        children: [
          for (final i in ReminderIntensity.values)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ChoiceRow(
                label: switch (i) {
                  ReminderIntensity.low => 'Low',
                  ReminderIntensity.medium => 'Medium',
                  ReminderIntensity.high => 'High',
                },
                hint: switch (i) {
                  ReminderIntensity.low => 'Rarely — I\'ll check in myself',
                  ReminderIntensity.medium => 'A few helpful nudges',
                  ReminderIntensity.high => 'Keep me on track',
                },
                selected: value == i,
                onTap: () => onChanged(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.label,
    required this.hint,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String hint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? color : theme.dividerColor,
            width: selected ? 2 : 1,
          ),
          color: selected ? color.withValues(alpha: 0.08) : null,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(hint,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.hintColor)),
              ],
            ),
            const Spacer(),
            if (selected) Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }
}
