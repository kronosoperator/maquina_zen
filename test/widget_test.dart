import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maquina_zen/app.dart';
import 'package:maquina_zen/state/key_value_store.dart';
import 'package:maquina_zen/state/zen_controller.dart';
import 'package:maquina_zen/ui/about_screen.dart';

void main() {
  late ZenController controller;

  Future<void> pumpApp(WidgetTester tester) async {
    controller = ZenController(store: InMemoryStore(), random: Random(5));
    await tester.pumpWidget(MaquinaZenApp(controller: controller));
    await tester.pumpAndSettle();
  }

  testWidgets('shows a quote and its master on launch', (tester) async {
    await pumpApp(tester);
    final quote = controller.current;

    expect(find.text(quote.en), findsOneWidget);
    expect(find.text(quote.master.name.toUpperCase()), findsOneWidget);
    expect(find.text('Nº 0001'), findsOneWidget);
    expect(find.text('tap the circle'), findsOneWidget);
  });

  testWidgets('tapping the ensō dispenses another quote', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpApp(tester);
    final first = controller.current;

    await tester.tap(find.bySemanticsLabel('Another quote'));
    await tester.pumpAndSettle();

    expect(controller.current, isNot(same(first)));
    expect(find.text(first.en), findsNothing);
    expect(find.text(controller.current.en), findsOneWidget);
    expect(find.text('Nº 0002'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('a quote can be saved, found in the sheet and removed', (
    tester,
  ) async {
    await pumpApp(tester);
    final quote = controller.current;

    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(controller.isSaved(quote), isTrue);

    await tester.tap(find.byTooltip('Saved'));
    await tester.pumpAndSettle();
    expect(find.text(quote.en), findsNWidgets(2));

    await tester.tap(find.byTooltip('Remove from saved').last);
    await tester.pumpAndSettle();
    expect(controller.isSaved(quote), isFalse);
    expect(find.textContaining('Nothing saved yet.'), findsOneWidget);
  });

  testWidgets('the wordmark opens the hidden about page', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('MÁQUINA ZEN'));
    await tester.pumpAndSettle();
    expect(find.text('vibe coded by Ivan Robayo'), findsOneWidget);
    expect(find.text('Know more on ivanro.com'), findsOneWidget);
    expect(find.text('draw your own circle'), findsOneWidget);

    await tester.drag(find.byType(AboutScreen), const Offset(80, 120));
    await tester.pumpAndSettle();
    final hint = tester.widget<AnimatedOpacity>(
      find.ancestor(
        of: find.text('draw your own circle'),
        matching: find.byType(AnimatedOpacity),
      ),
    );
    expect(hint.opacity, 0);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
    expect(find.text('vibe coded by Ivan Robayo'), findsNothing);
  });

  testWidgets('switching language shows the quote in Spanish', (tester) async {
    await pumpApp(tester);
    final quote = controller.current;

    await tester.tap(find.text('EN'));
    await tester.pumpAndSettle();

    expect(controller.locale, const Locale('es'));
    expect(find.text(quote.es), findsOneWidget);
    expect(find.text('toca el círculo'), findsOneWidget);
  });
}
