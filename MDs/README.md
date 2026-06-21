# 📚 ME App — Documentation

Welcome! This folder is your **learning guide and project diary**. It explains —
in plain English, assuming you've never used Flutter — what the app is, how it's
built, and what we did and why.

> **Ground rule:** Every time we do meaningful work on the app, it gets written
> down here so you can read through and understand it. You should never have to
> guess what changed or why.

## How these docs are organized

| Folder | What's inside | Read it when… |
|--------|---------------|---------------|
| [`concepts/`](concepts/) | Flutter & coding basics explained from zero | You see a word/idea you don't understand |
| [`architecture/`](architecture/) | How the project is structured and *why* | You want the big-picture map of the code |
| [`build-log/`](build-log/) | A dated diary of what we built each session | You want to know "what did we actually do?" |
| [`decisions/`](decisions/) | Big technical choices and the reasoning | You wonder "why did we pick X over Y?" |
| [`glossary.md`](glossary.md) | Quick definitions of every technical term | You need a one-line reminder of a word |

## Suggested reading order (for a beginner)

1. [`concepts/01-what-is-flutter.md`](concepts/01-what-is-flutter.md) — what Flutter and Dart even are
2. [`concepts/02-how-a-flutter-app-is-organized.md`](concepts/02-how-a-flutter-app-is-organized.md) — the files and folders
3. [`architecture/01-the-big-picture.md`](architecture/01-the-big-picture.md) — how our app is layered
4. [`build-log/2026-06-19-session-01.md`](build-log/2026-06-19-session-01.md) — exactly what we built first
5. [`build-log/2026-06-19-session-02.md`](build-log/2026-06-19-session-02.md) — the Bible pillar + navigation
6. [`build-log/2026-06-19-session-03.md`](build-log/2026-06-19-session-03.md) — the Finance pillar
7. [`build-log/2026-06-19-session-04.md`](build-log/2026-06-19-session-04.md) — the Focus pillar (live timer)
8. [`build-log/2026-06-19-session-05.md`](build-log/2026-06-19-session-05.md) — the Health pillar (all 5 done 🎉)
9. [`build-log/2026-06-19-session-06.md`](build-log/2026-06-19-session-06.md) — cross-pillar wiring into Today
10. [`build-log/2026-06-20-session-07.md`](build-log/2026-06-20-session-07.md) — daily reflections
11. [`build-log/2026-06-20-session-08.md`](build-log/2026-06-20-session-08.md) — reflections feed the suggestion engine
12. [`build-log/2026-06-20-session-09.md`](build-log/2026-06-20-session-09.md) — onboarding + settings store
13. [`build-log/2026-06-20-session-10.md`](build-log/2026-06-20-session-10.md) — settings screen
14. [`build-log/2026-06-20-session-11.md`](build-log/2026-06-20-session-11.md) — making the adaptivity visible (pillar scores + day shape)
15. [`build-log/2026-06-21-session-12.md`](build-log/2026-06-21-session-12.md) — tappable pillars + weekly review
16. [`build-log/2026-06-21-session-13.md`](build-log/2026-06-21-session-13.md) — weekly reflection prompts
17. [`build-log/2026-06-21-session-14.md`](build-log/2026-06-21-session-14.md) — identity: greeting, motto, app name
18. [`concepts/`](concepts/) — the rest, as needed

### All concept pages
- [01 · What is Flutter & Dart](concepts/01-what-is-flutter.md)
- [02 · How a Flutter app is organized](concepts/02-how-a-flutter-app-is-organized.md)
- [03 · Widgets & screens](concepts/03-widgets-and-screens.md)
- [04 · State & Riverpod](concepts/04-state-and-riverpod.md)
- [05 · Database with Drift](concepts/05-database-drift.md)
- [06 · Navigation & database migrations](concepts/06-navigation-and-migrations.md)

## What is this app, in one sentence?

**ME (Personal OS)** is a phone app that helps you grow in five areas of life —
Finance, Learning, Spiritual, Focus, and Health — by suggesting a *small* number
of useful actions each day instead of overwhelming you.

The full product plan lives in [`../personal-os-spec.md`](../personal-os-spec.md).
