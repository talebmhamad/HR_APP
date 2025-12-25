import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/storage/sharedpreferenceshelper.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  static const supportedLanguageCodes = ['en', 'ar'];

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final saved = await SharedPreferencesHelper.loadLanguage();
    if (saved != null && supportedLanguageCodes.contains(saved)) {
      _locale = Locale(saved);
      notifyListeners();
    }
  }

  Future<void> setLanguage(String code) async {
    if (!supportedLanguageCodes.contains(code)) return;

    _locale = Locale(code);
    await SharedPreferencesHelper.saveLanguage(code);
    notifyListeners();
  }
}
