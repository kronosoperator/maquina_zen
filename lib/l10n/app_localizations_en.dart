// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Máquina Zen';

  @override
  String get tapHint => 'tap the circle';

  @override
  String get newQuote => 'Another quote';

  @override
  String get save => 'Save';

  @override
  String get unsave => 'Remove from saved';

  @override
  String get share => 'Share';

  @override
  String get copied => 'Copied';

  @override
  String get saved => 'Saved';

  @override
  String get savedEmpty => 'Nothing saved yet.\nNothing missing, either.';

  @override
  String get switchLanguage => 'Leer en español';

  @override
  String get aboutDrawHint => 'draw your own circle';

  @override
  String get aboutCredit => 'vibe coded by Ivan Robayo';

  @override
  String get aboutLink => 'Know more on ivanro.com';
}
