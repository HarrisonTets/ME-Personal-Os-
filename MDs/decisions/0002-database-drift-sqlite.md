# Decision 0002 · Use Drift + SQLite for storage

**Date:** 2026-06-19 · **Status:** Accepted

## The decision
Store data **locally on the phone** using **SQLite**, accessed through the
**Drift** package.

## The choice we faced
Options for local storage in Flutter:
- **Drift (SQLite)** — a relational database (spreadsheet-like tables that link
  together).
- **Isar** — a fast object database.
- **Hive** — a simple key-value store.

## Why Drift
Our data is **relational** by nature: Pillars → Goals → Habits → Logs, all
linked. Drift/SQLite handles these relationships and analytics queries ("total
spent per category this month") naturally. It's also type-safe (catches errors
early) and has a clear path to optional cloud sync later.

## Trade-offs we accepted
- Drift requires a **code-generation step** (`dart run build_runner build`) —
  one extra command when we change the tables. Worth it for the safety.
- Hive would be simpler to start but too weak for the relational/analytics needs
  in the spec.

## What it looks like in our code
Tables in `lib/data/local/app_database.dart`; generated plumbing in
`app_database.g.dart`.

See concept page: [concepts/05-database-drift.md](../concepts/05-database-drift.md)
