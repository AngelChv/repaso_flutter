import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:repaso_flutter/presentation/view_models/language_view_model.dart';
import 'package:repaso_flutter/presentation/view_models/theme_view_model.dart';
import '../widgets/app_drawer.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();
    final languageVM = context.watch<LanguageViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.darkMode),
              trailing: Switch(
                value: themeVM.isDarkTheme,
                onChanged: (value) =>
                    context.read<ThemeViewModel>().toggleDarkTheme(),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              trailing: DropdownMenu<String>(
                initialSelection: languageVM.selectedLanguage,
                dropdownMenuEntries: languageVM.languages.entries.map((entry) {
                  return DropdownMenuEntry<String>(
                      value: entry.key, label: entry.value);
                }).toList(),
                onSelected: (value) {
                  context.read<LanguageViewModel>().changeLanguage(value!);
                },
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}
