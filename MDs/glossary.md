# 📖 Glossary

Quick, plain-English definitions. Skim it whenever a term trips you up.

| Term | Plain meaning |
|------|---------------|
| **Flutter** | Google's toolkit for building one app that runs on Android, iPhone, etc. |
| **Dart** | The programming language Flutter uses. Our files end in `.dart`. |
| **Compile / build** | Translate our written code into an app the phone can run. |
| **APK** | The installable app file for Android (output of a build). |
| **Emulator** | A simulated phone on your computer, for testing. |
| **Package / dependency** | Pre-made code from others that we reuse. Listed in `pubspec.yaml`. |
| **`pubspec.yaml`** | The project's list of packages + settings (the "shopping list"). |
| **`flutter pub get`** | Command that downloads the packages in `pubspec.yaml`. |
| **`lib/`** | The folder holding our app's code. |
| **`main.dart`** | The file where the app starts running. |
| **Widget** | Any visual building block (text, button, card, whole screen). A LEGO brick. |
| **`build()`** | A widget's method that lists the smaller widgets it's made of. |
| **StatelessWidget** | A widget that doesn't change on its own. |
| **ConsumerWidget** | A widget that redraws when watched app-data changes (Riverpod). |
| **Scaffold** | The standard page skeleton (body, app bar, etc.). |
| **State** | Data that changes while the app runs and the screen cares about. |
| **State management** | Keeping data and the screen in sync, cleanly. |
| **Riverpod** | The package we use for state management. |
| **Provider** | A labeled container that hands out a piece of data or logic. |
| **`ref.watch`** | Get a value *and* auto-redraw when it changes. |
| **`ref.read`** | Get a value once, no auto-updates (for one-off actions). |
| **Controller** | The middle-man holding a screen's logic (e.g. `TodayController`). |
| **Database** | Organized storage that survives app restarts. |
| **Local-first** | Data lives on the phone; the app works offline. |
| **SQLite** | The small, reliable database engine inside the phone. |
| **Drift** | The package that talks to SQLite for us, using Dart code. |
| **Table** | A spreadsheet-like store: columns (what) + rows (entries). |
| **Repository** | A clean middle-layer between the app and the database. |
| **Code generation** | Auto-writing boilerplate code from our description. |
| **`.g.dart`** | A generated file. **Never edit by hand** — re-run codegen instead. |
| **`build_runner`** | The tool that runs code generation (`dart run build_runner build`). |
| **Clean Architecture** | Splitting code into Domain (brain) / Data (memory) / Presentation (face). |
| **Domain layer** | Pure rules & concepts; knows nothing about screens or storage. |
| **Data layer** | The part that saves/loads data. |
| **Presentation layer** | The screens and buttons you see. |
| **Entity** | A core "noun" of the app (Habit, Pillar, Suggestion). |
| **Use case** | One unit of business logic (e.g. "generate today's suggestions"). |
| **Interface** | A promise describing *what* methods something must have, not *how*. |
| **Pillar** | One of the 5 life areas: Finance, Learning, Spiritual, Focus, Health. |
| **Gradle** | Android's build tool. Downloaded once on the first Android build (slow). |
| **git** | The system that tracks the history of changes to our code. |
| **`flutter analyze`** | Command that scans code for mistakes without running it. |
| **`flutter test`** | Command that runs our automated tests. |
