import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repaso_flutter/presentation/view_models/language_view_model.dart';
import 'package:repaso_flutter/presentation/view_models/theme_view_model.dart';
import 'package:repaso_flutter/presentation/views/converter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeViewModel()),
      ChangeNotifierProvider(create: (context) => LanguageViewModel()),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final languageKey = context.watch<LanguageViewModel>().selectedLanguage;
    return MaterialApp(
      locale: Locale(languageKey),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<ThemeViewModel>().themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Converter(),
    );
  }
}
