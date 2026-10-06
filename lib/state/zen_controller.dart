import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../quotes/quote.dart';
import '../quotes/quote_deck.dart';
import '../quotes/quotes.dart';
import 'key_value_store.dart';

class ZenController extends ChangeNotifier {
  ZenController({
    required KeyValueStore store,
    List<Quote> quotes = kQuotes,
    Random? random,
  }) : _store = store,
       _deck = QuoteDeck(quotes, random: random),
       _byId = {for (final quote in quotes) quote.id: quote} {
    // Ids of quotes that were later removed from the collection are dropped.
    _savedIds = [...?store.getStringList(_savedKey)]
        .where(_byId.containsKey)
        .toList();
    _dispensed = store.getInt(_dispensedKey) ?? 0;
    final languageCode = store.getString(_localeKey);
    _locale = languageCode == null ? null : Locale(languageCode);
    _draw();
  }

  static const _savedKey = 'saved_quote_ids';
  static const _dispensedKey = 'dispensed_count';
  static const _localeKey = 'locale';

  final KeyValueStore _store;
  final QuoteDeck _deck;
  final Map<String, Quote> _byId;

  late List<String> _savedIds;
  late int _dispensed;
  late Quote _current;
  Locale? _locale;

  Quote get current => _current;

  /// How many quotes this machine has dispensed since it was installed.
  int get dispensed => _dispensed;

  /// The user's language choice, or null to follow the device.
  Locale? get locale => _locale;

  /// Saved quotes, most recently saved first.
  List<Quote> get saved => [for (final id in _savedIds.reversed) _byId[id]!];

  bool isSaved(Quote quote) => _savedIds.contains(quote.id);

  void dispense() {
    _draw();
    notifyListeners();
  }

  /// Brings a known quote back on screen without dispensing a new one.
  void show(Quote quote) {
    if (identical(quote, _current)) return;
    _current = quote;
    notifyListeners();
  }

  void toggleSaved(Quote quote) {
    if (!_savedIds.remove(quote.id)) _savedIds.add(quote.id);
    _store.setStringList(_savedKey, _savedIds);
    notifyListeners();
  }

  void setLocale(Locale? locale) {
    if (locale == _locale) return;
    _locale = locale;
    if (locale == null) {
      _store.remove(_localeKey);
    } else {
      _store.setString(_localeKey, locale.languageCode);
    }
    notifyListeners();
  }

  void _draw() {
    _current = _deck.draw();
    _dispensed++;
    _store.setInt(_dispensedKey, _dispensed);
  }
}
