# 03 · Widgets — how screens are built

## Everything you see is a "Widget"

In Flutter, **every visual thing is a Widget**. A button is a widget. A piece of
text is a widget. A whole screen is a widget. Even invisible things like spacing
and layout are widgets.

> Think of widgets like **LEGO bricks**. Small bricks snap together to form
> bigger bricks, which snap together to form the whole app.

Examples of built-in widgets we use:

| Widget | What it does |
|--------|--------------|
| `Text('Today')` | Shows the words "Today" |
| `Icon(Icons.favorite)` | Shows a heart icon |
| `Row` / `Column` | Arranges children side-by-side / stacked |
| `Card` | A rounded box with a subtle border |
| `Scaffold` | The standard page skeleton (body, app bar, etc.) |
| `ListView` | A scrollable list of things |

## Widgets nest inside each other

A screen is just widgets placed inside widgets. Simplified, our Today screen
looks like:

```
Scaffold                     (the page)
└── ListView                 (scrollable area)
    ├── Header               (the date + progress bar)
    ├── SuggestionCard       (one suggested action)
    ├── SuggestionCard       (another one)
    └── ... etc
```

Each `SuggestionCard` is itself made of smaller widgets (an icon, the habit
name, the time estimate, a checkmark button).

## "Build" — how a widget describes itself

Every widget has a `build()` method. Its job is to **return the smaller widgets
it's made of**. Flutter calls `build()` whenever the screen needs to be drawn.

```dart
Widget build(BuildContext context) {
  return Text('Hello');   // "I am just the word Hello"
}
```

You'll see `build()` everywhere — it's the heart of how Flutter draws things.

## Two flavors of widget you'll see in our code

- **StatelessWidget** — a widget that never changes on its own (e.g. a label).
- **ConsumerWidget** — like a stateless widget, but it can *listen* to the app's
  data and redraw when that data changes. We use this for the Today screen so it
  updates the moment you tick off a habit. (The "Consumer" part comes from
  Riverpod — see the next page.)

## Our actual widget files

- `lib/presentation/today/today_screen.dart` — the whole Today page
- `lib/presentation/today/widgets/suggestion_card.dart` — one action card

## Key words from this page

| Word | Plain meaning |
|------|---------------|
| Widget | Any visual building block (LEGO brick) |
| `build()` | The method where a widget lists what it's made of |
| StatelessWidget | A widget that doesn't change by itself |
| ConsumerWidget | A widget that redraws when app data changes |
| Scaffold | The standard page skeleton |

➡️ Next: [04 · State management with Riverpod](04-state-and-riverpod.md)
