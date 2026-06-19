import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../domain/usecases/auto_complete_habits.dart';

part 'app_database.g.dart';

/// Recurring actions. Enum-typed columns ([pillar], [difficulty]) are stored as
/// their stable string [name] so the schema is readable and order-independent.
@DataClassName('HabitRow')
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get pillar => text()();
  TextColumn get difficulty => text()();
  IntColumn get estimatedMinutes => integer().withDefault(const Constant(10))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Optional cross-pillar link: when a matching activity happens, this habit is
  /// auto-completed on Today. See HabitTriggers.
  TextColumn get triggerKey => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Dated outcomes for habits. [date] is stored at local midnight (date-only).
@DataClassName('HabitLogRow')
class HabitLogs extends Table {
  TextColumn get id => text()();
  TextColumn get habitId =>
      text().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text()();
  TextColumn get mood => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// A Bible reading plan (e.g. "Gospel of John").
@DataClassName('BiblePlanRow')
class BiblePlans extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get totalDays => integer()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// One day's reading inside a plan. [completedAt] null = not yet read.
@DataClassName('ReadingAssignmentRow')
class ReadingAssignments extends Table {
  TextColumn get id => text()();
  TextColumn get planId =>
      text().references(BiblePlans, #id, onDelete: KeyAction.cascade)();
  IntColumn get dayNumber => integer()();
  TextColumn get reference => text()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// A Quiet Time reflection, optionally linked to the reading that prompted it.
@DataClassName('JournalEntryRow')
class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get reference => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get assignmentId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Income/expense records for the Finance pillar. [amount] is a plain number
/// (real) — fine for a personal tracker.
@DataClassName('FinanceEntryRow')
class FinanceEntries extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Completed deep-work sessions for the Focus pillar.
@DataClassName('FocusSessionRow')
class FocusSessions extends Table {
  TextColumn get id => text()();
  TextColumn get intention => text()();
  IntColumn get plannedMinutes => integer()();
  IntColumn get focusedMinutes => integer()();
  BoolColumn get completed => boolean()();
  DateTimeColumn get startedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Wellness data points for the Health pillar. [value] is in the type's natural
/// unit (glasses, minutes or hours).
@DataClassName('HealthLogRow')
class HealthLogs extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  RealColumn get value => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Habits,
    HabitLogs,
    BiblePlans,
    ReadingAssignments,
    JournalEntries,
    FinanceEntries,
    FocusSessions,
    HealthLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'personal_os'));

  // Schema history:
  //   v1: Habits + HabitLogs
  //   v2: added Bible tables (BiblePlans, ReadingAssignments, JournalEntries)
  //   v3: added FinanceEntries
  //   v4: added FocusSessions
  //   v5: added HealthLogs
  //   v6: added Habits.triggerKey (cross-pillar auto-complete) + backfill
  @override
  int get schemaVersion => 6;

  /// How the on-device database evolves between versions. Each `if (from < N)`
  /// block runs for installs older than N, adding what that version introduced
  /// without losing the user's existing data.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(biblePlans);
            await m.createTable(readingAssignments);
            await m.createTable(journalEntries);
          }
          if (from < 3) {
            await m.createTable(financeEntries);
          }
          if (from < 4) {
            await m.createTable(focusSessions);
          }
          if (from < 5) {
            await m.createTable(healthLogs);
          }
          if (from < 6) {
            await m.addColumn(habits, habits.triggerKey);
            await _backfillTriggerKeys();
          }
        },
      );

  /// Existing installs already have the default habits but no [Habits.triggerKey].
  /// Match them by name so cross-pillar auto-complete works without re-seeding.
  Future<void> _backfillTriggerKeys() async {
    const mapping = {
      "Log yesterday's expenses": HabitTriggers.financeLog,
      "Read today's passage & reflect": HabitTriggers.bibleReading,
      'One deep focus session': HabitTriggers.focusSession,
      'Take a 10-minute walk': HabitTriggers.healthWalk,
      'Drink a glass of water': HabitTriggers.healthWater,
    };
    for (final entry in mapping.entries) {
      await (update(habits)..where((h) => h.name.equals(entry.key)))
          .write(HabitsCompanion(triggerKey: Value(entry.value)));
    }
  }
}
