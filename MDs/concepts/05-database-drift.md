# 05 · Storing data with Drift (the database)

## Why we need a database

The app has to **remember things** even after you close it: your habits, which
ones you completed, on which days. A **database** is an organized storage system
for exactly this.

Our database lives **on the phone itself** (not on the internet). That's called
**local-first**: the app works fully offline, and your private data (finances,
journal) stays on your device. We can add optional cloud backup later.

## What is SQLite?

**SQLite** is a tiny, reliable database that runs inside a single file on the
device. It's the most widely used database in the world — it's literally inside
your phone already. Our app stores everything in one SQLite file.

## What is Drift?

Writing raw database commands is fiddly and error-prone. **Drift** is a package
that lets us describe our data using normal Dart code, and it handles the
database commands for us. It also catches mistakes *before* the app runs.

> Analogy: SQLite is the filing cabinet. Drift is a smart assistant who knows
> exactly how to file and fetch things for you, in plain language.

## Tables = spreadsheets

A database stores data in **tables**. A table is like a spreadsheet: columns
define *what* you store, rows are the actual entries.

We have two tables (`lib/data/local/app_database.dart`):

**`Habits`** — one row per habit:

| id | name | pillar | difficulty | estimatedMinutes |
|----|------|--------|------------|------------------|
| a1 | Take a 10-minute walk | health | light | 10 |
| b2 | One deep focus session | focus | deep | 25 |

**`HabitLogs`** — one row each time you complete a habit on a day:

| id | habitId | date | status |
|----|---------|------|--------|
| x9 | a1 | 2026-06-19 | done |

From these two tables, the app can work out streaks, completion rates, and
progress.

## "Code generation" — why there's a `.g.dart` file

We describe the tables in `app_database.dart`. Then we run a command:

```bash
dart run build_runner build
```

This reads our description and **auto-writes** a companion file
`app_database.g.dart` containing all the tedious database plumbing. The `.g`
means "generated." **We never edit generated files by hand** — we change the
description and re-run the command.

## The "Repository" idea

We don't let our screens talk to the database directly. Instead there's a
**repository** — a clean middle-layer with simple methods like:

- `getActiveHabits()` — "give me all current habits"
- `setLog(...)` — "record that this habit was done today"

Why bother? Because if we later switch the storage (e.g. add cloud sync), we only
change the repository — the rest of the app doesn't notice. Ours is
`lib/data/repositories/habit_repository_impl.dart`.

## Key words from this page

| Word | Plain meaning |
|------|---------------|
| Database | Organized storage that survives app restarts |
| Local-first | Data lives on the phone; works offline |
| SQLite | The small database engine inside the phone |
| Drift | The package that talks to SQLite for us |
| Table | A spreadsheet-like store (columns + rows) |
| Code generation | Auto-writing boilerplate code from our description |
| `.g.dart` | A generated file — never edit by hand |
| Repository | Clean middle-layer between app and database |

➡️ Next: [architecture/01-the-big-picture.md](../architecture/01-the-big-picture.md)
