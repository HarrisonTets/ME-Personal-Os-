# ME · Personal OS

A Flutter personal-growth companion organised around five pillars — **Finance,
Learning, Spiritual, Focus, Health** — that suggests a small set of high-leverage
actions each day instead of overwhelming you with options.

See [`personal-os-spec.md`](personal-os-spec.md) for the full product & technical
specification.

## Status

Vertical slice in place: the **Today screen** end-to-end (Presentation → Domain →
Data) driven by a rule-based suggestion engine over seeded cross-pillar habits.

## Architecture

Clean Architecture with three layers. Dependencies point inward — the domain
knows nothing about Flutter or Drift.

```
lib/
  domain/          # Pure business logic (no Flutter, no DB)
    entities/      #   Habit, HabitLog, Pillar, Suggestion
    repositories/  #   Abstract interfaces (HabitRepository)
    usecases/      #   GenerateTodaySuggestions (the suggestion engine)
  data/            # Persistence + interface implementations
    local/         #   Drift database, tables, first-run seed
    repositories/  #   HabitRepositoryImpl (maps rows <-> entities)
  presentation/    # UI + state
    today/         #   Today screen, controller (Riverpod AsyncNotifier)
    theme/         #   App theme + pillar UI metadata
    providers/     #   DI wiring (database -> repo -> use case)
```

**Stack:** Riverpod (state/DI) · Drift/SQLite (local-first persistence) · Material 3.

## The suggestion engine

`GenerateTodaySuggestions` is a pure, deterministic function (today's date is
injected, not read from the clock) ranking habits by:

- **Pillar weakness** — weaker pillars (low 7-day completion) float to the top
- **Streak protection** — live streaks not yet continued today get a boost
- **Recency** — neglected habits resurface
- **Difficulty** — lighter habits break ties to build momentum

It then applies a **daily budget** and **per-pillar cap** for a small, balanced
list. Covered by unit tests in `test/`.

## Running

```bash
flutter pub get
dart run build_runner build      # generates Drift code (app_database.g.dart)
flutter run                      # Android is the primary target
flutter test                     # run the suggestion-engine tests
```

> Note: the Windows desktop target needs the Visual Studio C++ toolchain.
> Android is the primary platform.

## Roadmap

Next slices replicate this pattern per pillar (Finance quick-add, Bible Quiet
Time, Focus sessions, Health logging), then daily reflections feeding the
pillar scores. See the spec's §13 roadmap.
