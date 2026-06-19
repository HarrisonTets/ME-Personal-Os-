# Decision 0001 · Use Riverpod for state management

**Date:** 2026-06-19 · **Status:** Accepted

## The decision
Use **Riverpod** to manage app state (keeping data and screens in sync).

## The choice we faced
The two mainstream options in Flutter are **Riverpod** and **BLoC**. Both are
good and widely used.

## Why Riverpod
- **Less code / boilerplate** than BLoC for the same result — important since
  you're new and a smaller codebase is easier to read.
- **Compile-time safety** — many mistakes are caught before the app runs.
- Great at **dependency injection** (handing the right objects to the right
  places), which suits our cross-pillar suggestion engine.

## Trade-off we accepted
BLoC enforces more rigid structure that some large teams prefer. For a solo/small
build, that rigidity is overhead we don't need.

## What it looks like in our code
`Provider` objects in `lib/presentation/providers/app_providers.dart`, and a
`TodayController` that the Today screen watches.

See concept page: [concepts/04-state-and-riverpod.md](../concepts/04-state-and-riverpod.md)
