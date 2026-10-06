import 'package:flutter/material.dart';

/// Paper and ink by day, night and moonlight after dark, with one seal-red
/// accent borrowed from the stamp on a calligraphy scroll.
abstract final class ZenTheme {
  static const _paper = Color(0xFFF3EFE6);
  static const _ink = Color(0xFF1B1A18);
  static const _night = Color(0xFF111110);
  static const _moon = Color(0xFFE8E3D7);
  static const _seal = Color(0xFFB5432C);
  static const _sealAtNight = Color(0xFFDB6A50);

  static ThemeData light() =>
      _build(Brightness.light, surface: _paper, ink: _ink, seal: _seal);

  static ThemeData dark() =>
      _build(Brightness.dark, surface: _night, ink: _moon, seal: _sealAtNight);

  static ThemeData _build(
    Brightness brightness, {
    required Color surface,
    required Color ink,
    required Color seal,
  }) {
    final scheme = ColorScheme.fromSeed(seedColor: seal, brightness: brightness)
        .copyWith(
          primary: ink,
          onPrimary: surface,
          secondary: seal,
          onSecondary: surface,
          surface: surface,
          onSurface: ink,
          onSurfaceVariant: ink.withValues(alpha: 0.62),
          surfaceContainerLow: Color.lerp(surface, ink, 0.04),
          outlineVariant: ink.withValues(alpha: 0.14),
          inverseSurface: ink,
          onInverseSurface: surface,
        );

    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: surface,
      fontFamily: ZenType.family,
      splashFactory: NoSplash.splashFactory,
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: ink),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ink,
        contentTextStyle: ZenType.body.copyWith(color: surface),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

/// Colourless text styles; colour comes from the theme at the call site.
abstract final class ZenType {
  static const family = 'Cormorant Garamond';

  static TextStyle quote(double size) => TextStyle(
    fontFamily: family,
    fontSize: size,
    height: 1.28,
    fontVariations: const [FontVariation.weight(500)],
  );

  static const body = TextStyle(
    fontFamily: family,
    fontSize: 19,
    height: 1.3,
    fontVariations: [FontVariation.weight(500)],
  );

  static const detail = TextStyle(
    fontFamily: family,
    fontSize: 16,
    fontStyle: FontStyle.italic,
    fontVariations: [FontVariation.weight(500)],
  );

  /// Letter-spaced capitals for names and the wordmark.
  static const label = TextStyle(
    fontFamily: family,
    fontSize: 13,
    letterSpacing: 2.6,
    fontVariations: [FontVariation.weight(700)],
  );
}
