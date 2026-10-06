import 'package:flutter/material.dart';

import '../quotes/quote.dart';
import '../theme/zen_theme.dart';

class QuoteView extends StatelessWidget {
  const QuoteView({super.key, required this.quote, required this.languageCode});

  final Quote quote;
  final String languageCode;

  // Short lines get room to breathe; long passages stay on one screen.
  static double _sizeFor(String text) => switch (text.length) {
    < 50 => 38,
    < 110 => 32,
    < 200 => 27,
    _ => 24,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = quote.text(languageCode);
    final detail = [quote.source, quote.master.era].nonNulls.join('  ·  ');

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: ZenType.quote(_sizeFor(text))
                    .copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: 28),
              Container(width: 24, height: 1.5, color: scheme.secondary),
              const SizedBox(height: 20),
              Text(
                quote.master.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: ZenType.label.copyWith(color: scheme.onSurface),
              ),
              if (detail.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: ZenType.detail.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
