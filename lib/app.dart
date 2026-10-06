import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'state/zen_controller.dart';
import 'theme/zen_theme.dart';
import 'ui/home_screen.dart';

class MaquinaZenApp extends StatelessWidget {
  const MaquinaZenApp({super.key, required this.controller});

  final ZenController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        theme: ZenTheme.light(),
        darkTheme: ZenTheme.dark(),
        locale: controller.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(controller: controller),
      ),
    );
  }
}
