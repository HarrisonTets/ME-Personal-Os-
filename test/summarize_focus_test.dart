import 'package:flutter_test/flutter_test.dart';
import 'package:personal_os/domain/entities/focus_session.dart';
import 'package:personal_os/domain/usecases/summarize_focus.dart';

void main() {
  final start = DateTime(2026, 6, 19, 9);

  FocusSession session({
    required int focused,
    required bool completed,
    int planned = 25,
  }) =>
      FocusSession(
        id: 'id-$focused-$completed',
        intention: 'work',
        plannedMinutes: planned,
        focusedMinutes: focused,
        completed: completed,
        startedAt: start,
      );

  test('empty list returns the empty summary', () {
    final s = const SummarizeFocus()([]);
    expect(s.sessionCount, 0);
    expect(s.completedCount, 0);
    expect(s.totalFocusedMinutes, 0);
  });

  test('sums focused minutes and counts sessions + completions', () {
    final s = const SummarizeFocus()([
      session(focused: 25, completed: true),
      session(focused: 25, completed: true),
      session(focused: 10, completed: false), // ended early
    ]);

    expect(s.sessionCount, 3);
    expect(s.completedCount, 2);
    expect(s.totalFocusedMinutes, 60);
  });
}
