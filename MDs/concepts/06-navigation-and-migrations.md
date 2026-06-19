# 06 · Two new ideas: Navigation & Database Migrations

This session introduced two concepts worth understanding.

## A. Navigation — moving between screens

Until now the app had a single screen. Real apps have many, and you move
between them in two ways:

### 1. Tabs (the bottom bar)
The bar at the bottom of the screen with **Today** and **Bible** is a
`NavigationBar`. Tapping a tab swaps which section you're looking at. The tabs
are *siblings* — equal top-level areas of the app.

- Our code: `lib/presentation/shell/home_shell.dart`
- We use an **`IndexedStack`**, which keeps every tab alive in the background and
  just shows one at a time. So when you switch tabs and come back, your place is
  preserved (no reloading).

### 2. Pushing a page (drilling in)
When you tap **"Begin Quiet Time,"** a new screen slides in *on top* with a back
arrow. That's a **push**:

```dart
Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => QuietTimeScreen(assignment: reading)),
);
```

Think of it as a **stack of cards**: push adds a card on top; the back button
("pop") removes it and reveals the one beneath. Tabs = switching rooms; push =
opening a drawer inside a room.

## B. Database migrations — changing storage safely

Here's a real problem we hit. You already ran the app, so your phone has a
database with the **Habits** tables in it. Now we want to *add* new Bible tables.

If we just changed the code, the app would expect tables that don't exist in
*your* already-created database → crash.

The fix is a **migration**: a documented, step-by-step upgrade plan for the
database.

- Every database has a **schema version** (a number). Ours went from **1 → 2**.
- When the app opens and notices "the data on this phone is version 1, but the
  code wants version 2," it runs our **`onUpgrade`** steps — which create the new
  Bible tables **without deleting your existing habits/logs**.

Our code (`lib/data/local/app_database.dart`):

```dart
int get schemaVersion => 2;          // bumped from 1

MigrationStrategy get migration => MigrationStrategy(
  onCreate: (m) => m.createAll(),    // brand-new installs: make all tables
  onUpgrade: (m, from, to) async {   // existing installs: just add what's new
    if (from < 2) {
      await m.createTable(biblePlans);
      await m.createTable(readingAssignments);
      await m.createTable(journalEntries);
    }
  },
);
```

> **Why you should care:** This is how a real app evolves its data without ever
> losing what users already saved. Every time we add/-change a table from now on,
> we bump the version and add a migration step. We'll always note it in the build
> log.

## Key words from this page

| Word | Plain meaning |
|------|---------------|
| NavigationBar | The bottom tab bar switching app sections |
| IndexedStack | Keeps all tabs alive; shows one at a time |
| Push / Pop | Add / remove a screen on the navigation stack |
| Route | A single screen you can navigate to |
| Schema version | A number marking the database's "shape" version |
| Migration | The upgrade steps that evolve the DB without data loss |
| `onUpgrade` | The migration code that runs for existing installs |

➡️ Back to: [build-log/2026-06-19-session-02.md](../build-log/2026-06-19-session-02.md)
