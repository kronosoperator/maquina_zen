import 'dart:math';

import 'quote.dart';

/// Deals quotes like a shuffled deck: every quote comes up once before any
/// repeats, and a reshuffle never deals the same quote twice in a row.
class QuoteDeck {
  QuoteDeck(this._quotes, {Random? random})
    : assert(_quotes.isNotEmpty),
      _random = random ?? Random();

  final List<Quote> _quotes;
  final Random _random;
  final List<Quote> _pile = [];
  Quote? _last;

  Quote draw() {
    if (_pile.isEmpty) {
      _pile
        ..addAll(_quotes)
        ..shuffle(_random);
      if (_pile.length > 1 && identical(_pile.last, _last)) {
        _pile
          ..removeLast()
          ..insert(0, _last!);
      }
    }
    return _last = _pile.removeLast();
  }
}
