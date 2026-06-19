# Architecture · 01 · The big picture

## The problem we're avoiding

In a messy app, the screen code also talks to the database, also contains the
business rules, all tangled together. It works at first — then becomes a
nightmare to change or test. One small fix breaks three unrelated things.

## Our solution: three layers

We split the code into **three layers, each with one job**. This is a
well-known professional pattern called **Clean Architecture**.

```
┌─────────────────────────────────────────────┐
│  PRESENTATION  (the face)                    │  ← screens you see & tap
│  "Show the list. Tell the brain about taps." │
└───────────────────┬─────────────────────────┘
                    │ talks to
┌───────────────────▼─────────────────────────┐
│  DOMAIN  (the brain)                         │  ← rules & concepts
│  "What is a habit? Which actions to suggest?"│
└───────────────────┬─────────────────────────┘
                    │ talks to (through a clean interface)
┌───────────────────▼─────────────────────────┐
│  DATA  (the memory)                          │  ← saving & loading
│  "Store this in the database. Fetch that."   │
└─────────────────────────────────────────────┘
```

### 1. Domain — the brain 🧠
Pure rules and concepts. **Knows nothing about screens or databases.** This is
where "what is a Habit" and "which 5 actions should we suggest today" live.
Because it's pure, it's the easiest part to test.

- Folder: `lib/domain/`
- Example: `GenerateTodaySuggestions` (the suggestion engine)

### 2. Data — the memory 💾
Knows how to actually save and load things (using Drift/SQLite). It *implements*
the storage promises the domain asks for.

- Folder: `lib/data/`
- Example: `HabitRepositoryImpl`

### 3. Presentation — the face 👀
The screens and buttons. It shows what the domain produces and forwards your
taps. It's deliberately "dumb" — no business rules here.

- Folder: `lib/presentation/`
- Example: `TodayScreen`

## The golden rule: dependencies point inward

The **Domain (brain) doesn't depend on anything**. The outer layers depend on
it, never the reverse.

Why this is powerful:
- We can change the database (Data layer) **without touching** the brain or screens.
- We can redesign the screens (Presentation) **without touching** the rules.
- We can test the brain **without** a phone, database, or UI at all.

> Real proof from our project: the suggestion engine has **4 passing tests** that
> run in a fraction of a second — no database, no screen needed — because the
> brain is kept pure.

## How a single tap flows through the layers

When you tap "done" on a walk:

1. **Presentation**: the card tells `TodayController` "this was tapped."
2. **Data**: the controller asks the repository to save a "done" log → Drift
   writes it to SQLite.
3. **Data → Presentation**: the database emits "logs changed."
4. **Domain**: the suggestion engine recomputes the list with the new info.
5. **Presentation**: the screen redraws — the walk moves to "Completed," progress
   ticks up. All automatic.

➡️ Next: [02 · Folder-by-folder tour](02-folder-by-folder.md)
