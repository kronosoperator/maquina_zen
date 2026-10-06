import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:maquina_zen/quotes/quotes.dart';
import 'package:maquina_zen/state/key_value_store.dart';
import 'package:maquina_zen/state/zen_controller.dart';

void main() {
  ZenController build(InMemoryStore store) =>
      ZenController(store: store, random: Random(3));

  test('starts with a quote already dispensed', () {
    final controller = build(InMemoryStore());
    expect(kQuotes, contains(controller.current));
    expect(controller.dispensed, 1);
  });

  test('dispensing changes the quote, counts it and notifies', () {
    final controller = build(InMemoryStore());
    final first = controller.current;
    var notifications = 0;
    controller.addListener(() => notifications++);

    controller.dispense();

    expect(controller.current, isNot(same(first)));
    expect(controller.dispensed, 2);
    expect(notifications, 1);
  });

  test('the ticket counter survives a restart', () {
    final store = InMemoryStore();
    build(store).dispense();
    expect(build(store).dispensed, 3);
  });

  test('saved quotes survive a restart, newest first', () {
    final store = InMemoryStore();
    final controller = build(store);
    final first = controller.current;
    controller.toggleSaved(first);
    controller.dispense();
    final second = controller.current;
    controller.toggleSaved(second);

    final restarted = build(store);
    expect(restarted.saved, [second, first]);
    expect(restarted.isSaved(first), isTrue);
  });

  test('toggling a saved quote removes it', () {
    final controller = build(InMemoryStore());
    final quote = controller.current;
    controller.toggleSaved(quote);
    controller.toggleSaved(quote);
    expect(controller.saved, isEmpty);
  });

  test('saved ids of quotes that no longer exist are dropped', () {
    final store = InMemoryStore({
      'saved_quote_ids': ['retired-quote', kQuotes.first.id],
    });
    expect(build(store).saved, [kQuotes.first]);
  });

  test('show brings back a quote without dispensing', () {
    final controller = build(InMemoryStore());
    final other = kQuotes.firstWhere((q) => q != controller.current);
    controller.show(other);
    expect(controller.current, same(other));
    expect(controller.dispensed, 1);
  });

  test('the language choice survives a restart and can be cleared', () {
    final store = InMemoryStore();
    final controller = build(store);
    expect(controller.locale, isNull);

    controller.setLocale(const Locale('es'));
    expect(build(store).locale, const Locale('es'));

    controller.setLocale(null);
    expect(build(store).locale, isNull);
  });
}
