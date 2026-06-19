# Architecture · 02 · Folder-by-folder tour

Here's every file we've created so far and what it does, grouped by layer. Use
this as a map when you're reading the code.

## `lib/domain/` — the brain 🧠 (pure rules, no Flutter/database)

```
domain/
├── entities/                     ← the core "nouns" of the app
│   ├── pillar.dart               ← the 5 pillars (Finance, Learning, …)
│   ├── habit.dart                ← what a Habit is + its difficulty levels
│   ├── habit_log.dart            ← a record that a habit was done on a day
│   └── suggestion.dart           ← one suggested action + why it was chosen
├── repositories/
│   └── habit_repository.dart     ← a PROMISE: "storage must offer these methods"
│                                    (an interface — no actual code, just the shape)
└── usecases/
    └── generate_today_suggestions.dart  ← ⭐ the suggestion engine (the core logic)
```

**Why an "interface" in `repositories/`?** The brain says *what* it needs from
storage ("I need a way to get active habits") without caring *how*. The Data
layer fulfills that promise. This is what keeps the brain database-agnostic.

## `lib/data/` — the memory 💾 (saving & loading)

```
data/
├── local/
│   ├── app_database.dart         ← defines the database tables (Habits, HabitLogs)
│   ├── app_database.g.dart       ← AUTO-GENERATED plumbing (never edit by hand)
│   └── seed.dart                 ← inserts the 6 default starter habits on first run
└── repositories/
    └── habit_repository_impl.dart ← fulfills the brain's storage promise using Drift
```

## `lib/presentation/` — the face 👀 (screens & state)

```
presentation/
├── providers/
│   └── app_providers.dart        ← wiring: database → repository → engine
├── today/
│   ├── today_screen.dart         ← the Today page you see
│   ├── today_controller.dart     ← the middle-man holding the screen's logic
│   └── widgets/
│       └── suggestion_card.dart  ← one action card on the list
└── theme/
    ├── app_theme.dart            ← app colors & overall look
    └── pillar_ui.dart            ← each pillar's icon & color (UI-only)
```

## `lib/main.dart` — the front door

Boots the app: opens the database, seeds defaults on first run, shows the Today
screen.

## `test/` — automated checks

```
test/
└── generate_today_suggestions_test.dart  ← 4 tests proving the engine behaves
```

## Quick "where do I go to change X?" cheatsheet

| I want to change… | Go to… |
|-------------------|--------|
| How suggestions are chosen/ranked | `domain/usecases/generate_today_suggestions.dart` |
| What the Today screen looks like | `presentation/today/today_screen.dart` |
| The look of one action card | `presentation/today/widgets/suggestion_card.dart` |
| The default starter habits | `data/local/seed.dart` |
| What data we store about a habit | `data/local/app_database.dart` (then re-run codegen) |
| App colors | `presentation/theme/app_theme.dart` |
| A pillar's icon/color | `presentation/theme/pillar_ui.dart` |

➡️ See also: [build-log/2026-06-19-session-01.md](../build-log/2026-06-19-session-01.md)
