import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('en', 'US');

  Locale get currentLocale => _currentLocale;

  static const Map<String, Locale> supportedLocales = {
    'English': Locale('en', 'US'),
    'සිංහල': Locale('si', 'LK'),
    'தமிழ்': Locale('ta', 'LK'),
  };

  LanguageProvider() {
    _loadLanguageFromStorage();
  }

  Future<void> _loadLanguageFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    final countryCode = prefs.getString('country_code') ?? 'US';

    _currentLocale = Locale(languageCode, countryCode);
    notifyListeners();
  }

  Future<void> changeLanguage(Locale locale) async {
    if (_currentLocale != locale) {
      _currentLocale = locale;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', locale.languageCode);
      await prefs.setString('country_code', locale.countryCode ?? '');

      notifyListeners();
    }
  }

  String getLanguageName() {
    switch (_currentLocale.languageCode) {
      case 'si':
        return 'සිංහල';
      case 'ta':
        return 'தமிழ்';
      default:
        return 'English';
    }
  }

  bool get isEnglish => _currentLocale.languageCode == 'en';
  bool get isSinhala => _currentLocale.languageCode == 'si';
  bool get isTamil => _currentLocale.languageCode == 'ta';
}
