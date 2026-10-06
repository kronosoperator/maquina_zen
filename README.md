# Máquina Zen

Pequeñas citas al azar de maestros zen. One circle, one quote.

Tap the ensō and the machine dispenses a line from a Zen master, in Spanish or
English, with the work it comes from.

## Run

```sh
flutter pub get
flutter run
```

## Layout

```
lib/
  main.dart            entry point; opens storage, starts the app
  app.dart             MaterialApp: themes, locale
  quotes/              Quote model, the collection, the shuffled deck
  state/               ZenController and the key-value store behind it
  theme/               colours and type
  ui/                  home screen, ensō button, quote view, saved sheet
  l10n/                UI strings (app_en.arb, app_es.arb)
```

## Adding a quote

Add a `Quote` to `kQuotes` in `lib/quotes/quotes.dart` with both `en` and `es`
text. Give it a new, permanent `id`: saved quotes are stored by id, so an id
must never be renamed or reused. Only add lines that can be traced to a named
work or a well-documented saying.

## Test

```sh
flutter analyze
flutter test
```

## Credits

Set in Cormorant Garamond (SIL Open Font License, see `assets/fonts/OFL.txt`).
