import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:maquina_zen/quotes/quote_deck.dart';
import 'package:maquina_zen/quotes/quotes.dart';

void main() {
  group('kQuotes', () {
    test('ids are unique', () {
      final ids = kQuotes.map((quote) => quote.id).toSet();
      expect(ids, hasLength(kQuotes.length));
    });

    test('every quote has text in both languages', () {
      for (final quote in kQuotes) {
        expect(quote.en.trim(), isNotEmpty, reason: quote.id);
        expect(quote.es.trim(), isNotEmpty, reason: quote.id);
        expect(quote.es, isNot(quote.en), reason: quote.id);
      }
    });
  });

  group('QuoteDeck', () {
    test('deals every quote once before repeating', () {
      final deck = QuoteDeck(kQuotes, random: Random(1));
      final round = [for (var i = 0; i < kQuotes.length; i++) deck.draw()];
      expect(round.toSet(), hasLength(kQuotes.length));
    });

    test('never deals the same quote twice in a row', () {
      // A tiny deck makes a back-to-back repeat across reshuffles likely.
      final deck = QuoteDeck(kQuotes.take(3).toList(), random: Random(7));
      var previous = deck.draw();
      for (var i = 0; i < 500; i++) {
        final next = deck.draw();
        expect(next, isNot(same(previous)));
        previous = next;
      }
    });

    test('a single-quote deck keeps dealing it', () {
      final deck = QuoteDeck([kQuotes.first]);
      expect(deck.draw(), same(kQuotes.first));
      expect(deck.draw(), same(kQuotes.first));
    });
  });
}
