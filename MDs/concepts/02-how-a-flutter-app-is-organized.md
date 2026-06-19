# 02 · How a Flutter app is organized (files & folders)

When we created the project, Flutter generated a lot of files. Here's what the
important ones do. You can safely ignore most of the rest for now.

## Top-level folders

```
ME/
├── lib/            ← 🟢 THIS is where (almost) all our code lives
├── test/           ← Automated tests that check our code works
├── android/        ← Android-specific settings (auto-generated, rarely touched)
├── windows/        ← Windows-specific settings (auto-generated)
├── build/          ← Temporary output (the APK ends up here). Not edited by hand.
├── MDs/            ← 📚 These documentation notes (added for you)
├── pubspec.yaml    ← The "shopping list" of the project (see below)
├── personal-os-spec.md  ← The product plan
└── README.md       ← Short project summary
```

> **Rule of thumb:** You'll spend ~95% of your time in `lib/` and these `MDs/`.

## `pubspec.yaml` — the project's shopping list

`pubspec.yaml` lists the **packages** (pre-made code written by other people)
that our app uses, so we don't reinvent everything. Think of it like a recipe's
ingredient list. Ours includes:

- `flutter_riverpod` — manages the app's data/state (explained later)
- `drift` — lets us store data in a database on the phone
- `uuid` — generates unique IDs
- `intl` — formats dates nicely ("Thursday, Jun 19")

When you change this file, you run `flutter pub get` to actually download the
ingredients.

## `lib/` — where our code lives

Inside `lib/` we organized the code into **layers** (a clean, professional
structure). The short version:

```
lib/
├── main.dart        ← The starting point — the app "boots" from here
├── domain/          ← The brain: rules & concepts (no screens, no database)
├── data/            ← The memory: saving/loading from the database
└── presentation/    ← The face: the screens you see and tap
```

We explain *why* it's split this way in
[architecture/01-the-big-picture.md](../architecture/01-the-big-picture.md).

## `main.dart` — the front door

Every Flutter app starts running from a function called `main()`. Ours lives in
`lib/main.dart`. When the app launches it:

1. Opens the database,
2. Adds the default starter habits (only the very first time),
3. Shows the first screen (the **Today** screen).

## Key words from this page

| Word | Plain meaning |
|------|---------------|
| `lib/` | The folder holding our actual app code |
| Package | Pre-made code from others we reuse (a.k.a. dependency) |
| `pubspec.yaml` | The list of packages + app settings |
| `main.dart` | The file where the app starts running |
| Layer | A group of code with one job (brain / memory / face) |

➡️ Next: [03 · Widgets — how screens are built](03-widgets-and-screens.md)
