import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pillar.dart';
import '../providers/app_providers.dart';
import '../theme/pillar_ui.dart';

/// The live deep-work timer. Counts down from [plannedMinutes]; when it reaches
/// zero the session is saved as completed. The user can also end early, which
/// saves a partial (un-completed) session with the minutes actually focused.
class FocusSessionScreen extends ConsumerStatefulWidget {
  const FocusSessionScreen({
    super.key,
    required this.intention,
    required this.plannedMinutes,
  });

  final String intention;
  final int plannedMinutes;

  @override
  ConsumerState<FocusSessionScreen> createState() =>
      _FocusSessionScreenState();
}

class _FocusSessionScreenState extends ConsumerState<FocusSessionScreen> {
  late final int _totalSeconds = widget.plannedMinutes * 60;
  late int _remaining = _totalSeconds;
  late final DateTime _startedAt = DateTime.now();
  Timer? _timer;
  bool _finished = false;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick(Timer timer) {
    if (_remaining <= 1) {
      setState(() {
        _remaining = 0;
        _finished = true;
      });
      timer.cancel();
      _save(completed: true);
    } else {
      setState(() => _remaining--);
    }
  }

  /// Persists the session exactly once. [completed] true when the timer ran out.
  Future<void> _save({required bool completed}) async {
    if (_saved) return;
    _saved = true;
    final elapsed = _totalSeconds - _remaining;
    final focusedMinutes =
        completed ? widget.plannedMinutes : (elapsed / 60).floor();

    await ref.read(addFocusSessionProvider)(
      intention: widget.intention,
      plannedMinutes: widget.plannedMinutes,
      focusedMinutes: focusedMinutes,
      completed: completed,
      startedAt: _startedAt,
    );
  }

  Future<void> _endEarly() async {
    _timer?.cancel();
    await _save(completed: false);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  String get _clock {
    final m = (_remaining ~/ 60).toString().padLeft(2, '0');
    final s = (_remaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = PillarType.focus.color;
    final progress =
        _totalSeconds == 0 ? 0.0 : 1 - (_remaining / _totalSeconds);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Text(widget.intention,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 40),
              SizedBox(
                width: 240,
                height: 240,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 240,
                      height: 240,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 10,
                        backgroundColor: color.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation(color),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_clock,
                            style: theme.textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFeatures: const [])),
                        Text(_finished ? 'Done!' : 'remaining',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: theme.hintColor)),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (_finished)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.check),
                    label: const Text('Finish'),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: _endEarly,
                    icon: const Icon(Icons.stop),
                    label: const Text('End session early'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
