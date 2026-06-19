# 01 · What is Flutter (and Dart)?

## Flutter = a toolkit for building apps

**Flutter** is a free toolkit made by Google for building apps. The big selling
point: you write your app **once**, and it can run on:

- Android phones
- iPhones (iOS)
- Windows / Mac / Linux computers
- Web browsers

Without Flutter, you'd normally have to build the Android version and the iPhone
version **separately**, in different languages. Flutter lets one codebase cover
them all. That's why we picked it for your app.

## Dart = the language Flutter is written in

A program is just instructions written in a **programming language**. Flutter
uses a language called **Dart** (also by Google). So every code file we write
ends in `.dart`.

Don't worry about mastering Dart up front — you'll absorb it by reading the code
and these notes. A few things that'll help right away:

- A **variable** is a named box that holds a value: `final name = 'Harrison';`
- A **function** is a reusable instruction block: `int add(int a, int b) => a + b;`
- A **class** is a blueprint for an object (e.g. a `Habit` class describes what a
  habit *is*: it has a name, a pillar, etc.)

## How an app actually runs

When you "run" the app, Flutter:

1. Takes all your `.dart` files,
2. Compiles them (translates them) into something the phone understands,
3. Bundles them into an installable file (for Android, that's an **APK** file),
4. Installs and launches it on the device or emulator.

We already did step 1–3 successfully — we produced an `app-debug.apk`. ✅

## Key words from this page

| Word | Plain meaning |
|------|---------------|
| Flutter | The toolkit we build the app with |
| Dart | The programming language we write in |
| Compile | Translate human-written code into machine-runnable form |
| APK | The installable app file for Android |
| Emulator | A fake phone running on your computer for testing |

➡️ Next: [02 · How a Flutter app is organized](02-how-a-flutter-app-is-organized.md)
