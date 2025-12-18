// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // LANGUAGE
  static const String languageKey = "selected_language";

  static Future<void> saveLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, lang);
  }

  static Future<String?> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey);
  }

  // REMEMBER ME
  static const String rememberMeKey = "remember_me";
  static const String usernameKey = "saved_username";
  static const String passwordKey = "saved_password";

  static Future<void> saveRememberMe(
    bool value,
    String username,
    String password,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(rememberMeKey, value);

    if (value) {
      await prefs.setString(usernameKey, username);
      await prefs.setString(passwordKey, password);
    } else {
      await prefs.remove(usernameKey);
      await prefs.remove(passwordKey);
    }
  }

  static Future<Map<String, dynamic>> loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool remember = prefs.getBool(rememberMeKey) ?? false;
    String username = prefs.getString(usernameKey) ?? '';
    String password = prefs.getString(passwordKey) ?? '';

    return {"remember": remember, "username": username, "password": password};
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    // Clears all keys/value pairs stored by the app
    await prefs.clear();
  }
}
