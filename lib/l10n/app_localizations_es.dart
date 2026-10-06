// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Máquina Zen';

  @override
  String get tapHint => 'toca el círculo';

  @override
  String get newQuote => 'Otra cita';

  @override
  String get save => 'Guardar';

  @override
  String get unsave => 'Quitar de guardadas';

  @override
  String get share => 'Compartir';

  @override
  String get copied => 'Copiada';

  @override
  String get saved => 'Guardadas';

  @override
  String get savedEmpty => 'Nada guardado todavía.\nTampoco falta nada.';

  @override
  String get switchLanguage => 'Read in English';

  @override
  String get aboutDrawHint => 'dibuja tu propio círculo';

  @override
  String get aboutCredit => 'vibe coded por Ivan Robayo';

  @override
  String get aboutLink => 'Conoce más en ivanro.com';
}
