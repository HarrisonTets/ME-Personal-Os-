# 04 · State management with Riverpod

## What is "state"?

**State** = the data that can change while the app is running, and that the
screen needs to know about. Examples in our app:

- The list of today's suggested actions
- Whether each action is ticked off or not
- Progress ("2 of 5 done")

When state changes, the screen should update to match. The tricky part of app
development is: *how do you keep the data and the screen in sync, cleanly?*
That's called **state management**.

## Why we use Riverpod

**Riverpod** is a popular package that solves state management. It gives us two
big things:

1. **A tidy place to keep data**, separate from the screens.
2. **Automatic updates** — when the data changes, any screen watching it redraws
   itself. We don't have to manually refresh anything.

We chose Riverpod over the main alternative (BLoC) because it's less code and
friendlier to learn. (See
[decisions/0001-state-management-riverpod.md](../decisions/0001-state-management-riverpod.md).)

## The one word to learn: "Provider"

A **Provider** is a labeled container that *provides* a piece of data or
functionality to the rest of the app. You "ask" for it and Riverpod hands it to
you. This avoids passing data manually through dozens of widgets.

Real examples from our code (`lib/presentation/providers/app_providers.dart`):

| Provider | What it provides |
|----------|------------------|
| `appDatabaseProvider` | The database connection |
| `habitRepositoryProvider` | The thing that saves/loads habits |
| `generateTodaySuggestionsProvider` | The suggestion engine |
| `todayControllerProvider` | The live list of today's suggestions |

## "watch" vs "read"

When a widget wants data from a provider, it uses one of two verbs:

- **`ref.watch(...)`** — "give me this value **and** redraw me whenever it
  changes." Used when the screen should react to changes.
- **`ref.read(...)`** — "just give me this once, I don't need updates." Used for
  one-off actions, like when you tap a button.

Example: the Today screen does `ref.watch(todayControllerProvider)` so it
auto-updates when you complete a habit.

## The "Controller" idea

A **controller** is the middle-man between the screen and the data. The screen
says "the user tapped done on this habit" and the controller handles the actual
logic (save it, recompute the list). Ours is `TodayController` in
`lib/presentation/today/today_controller.dart`.

This keeps screens **dumb and simple** (just display + forward taps) and puts the
thinking in one place.

## Key words from this page

| Word | Plain meaning |
|------|---------------|
| State | Data that changes while the app runs |
| State management | Keeping data and screen in sync, cleanly |
| Riverpod | The package we use for state management |
| Provider | A labeled container that hands out data/logic |
| `ref.watch` | Get a value and auto-update when it changes |
| `ref.read` | Get a value once, no auto-updates |
| Controller | The middle-man holding a screen's logic |

➡️ Next: [05 · Storing data with Drift (the database)](05-database-drift.md)
