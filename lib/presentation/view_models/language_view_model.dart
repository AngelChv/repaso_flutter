import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageViewModel extends ChangeNotifier {
  LanguageViewModel() {
    SharedPreferences.getInstance().then((preferences) {
      _selectedLanguage = preferences.getString("language") ?? _selectedLanguage;
    });
  }

  static const Map<String, String> _languages = {
    "en": "English",
    "es": "Spanish"
  };
  Map<String, String> get languages => _languages;

  String _selectedLanguage = _languages.keys.first;
  get selectedLanguage => _selectedLanguage;
  changeLanguage(String language) {
    _selectedLanguage = language;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setString("language", language);
    });
    notifyListeners();
  }
}