import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repaso_flutter/presentation/view_models/conversor_view_model.dart';
import 'package:repaso_flutter/presentation/view_models/font_size_view_model.dart';
import 'package:repaso_flutter/presentation/view_models/language_view_model.dart';
import 'package:repaso_flutter/presentation/view_models/theme_view_model.dart';
import 'package:repaso_flutter/presentation/view_models/transactions_view_model.dart';
import 'package:repaso_flutter/presentation/views/converter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeViewModel()),
      ChangeNotifierProvider(create: (context) => LanguageViewModel()),
      ChangeNotifierProvider(create: (context) => TransactionViewModel()),
      ChangeNotifierProvider(create: (context) => ConversorViewModel()),
      ChangeNotifierProvider(create: (context) => FontSizeViewModel()),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final languageKey = context.watch<LanguageViewModel>().selectedLanguage;
    final fontSizeFactor = context.watch<FontSizeViewModel>().fontSizeFactor;
    return MaterialApp(
      locale: Locale(languageKey),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<ThemeViewModel>().themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        // Modificar el textScaleFactor
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(fontSizeFactor),
          ),
          child: child!,
        );
      },
      home: Converter(),
    );
  }
}
