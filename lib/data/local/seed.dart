import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/habit.dart';
import '../../domain/entities/pillar.dart';
import '../../domain/usecases/auto_complete_habits.dart';
import 'app_database.dart';

/// Seeds the default cross-pillar habits described in the spec's onboarding
/// (§6.1.1) on first launch. Idempotent: does nothing if habits already exist.
Future<void> seedDefaultHabitsIfEmpty(AppDatabase db) async {
  final existing = await db.select(db.habits).get();
  if (existing.isNotEmpty) return;

  const uuid = Uuid();
  final defaults = <({
    String name,
    String description,
    PillarType pillar,
    HabitDifficulty difficulty,
    int minutes,
    String? trigger,
  })>[
    (
      name: 'Log yesterday\'s expenses',
      description: 'Quick capture so nothing leaks.',
      pillar: PillarType.finance,
      difficulty: HabitDifficulty.light,
      minutes: 5,
      trigger: HabitTriggers.financeLog,
    ),
    (
      name: '15-min learning session',
      description: 'Pick up a topic where you left off.',
      pillar: PillarType.learning,
      difficulty: HabitDifficulty.medium,
      minutes: 15,
      trigger: null, // no Learning pillar feature yet
    ),
    (
      name: 'Read today\'s passage & reflect',
      description: 'Quiet time + one sentence of reflection.',
      pillar: PillarType.spiritual,
      difficulty: HabitDifficulty.light,
      minutes: 10,
      trigger: HabitTriggers.bibleReading,
    ),
    (
      name: 'One deep focus session',
      description: '25 minutes on your most important task.',
      pillar: PillarType.focus,
      difficulty: HabitDifficulty.deep,
      minutes: 25,
      trigger: HabitTriggers.focusSession,
    ),
    (
      name: 'Take a 10-minute walk',
      description: 'Move your body and reset.',
      pillar: PillarType.health,
      difficulty: HabitDifficulty.light,
      minutes: 10,
      trigger: HabitTriggers.healthWalk,
    ),
    (
      name: 'Drink a glass of water',
      description: 'Stay hydrated through the day.',
      pillar: PillarType.health,
      difficulty: HabitDifficulty.light,
      minutes: 1,
      trigger: HabitTriggers.healthWater,
    ),
  ];

  await db.batch((batch) {
    for (final d in defaults) {
      batch.insert(
        db.habits,
        HabitsCompanion.insert(
          id: uuid.v4(),
          name: d.name,
          description: Value(d.description),
          pillar: d.pillar.storageKey,
          difficulty: d.difficulty.storageKey,
          estimatedMinutes: Value(d.minutes),
          triggerKey: Value(d.trigger),
        ),
      );
    }
  });
}
