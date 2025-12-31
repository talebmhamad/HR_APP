import '../core/storage/sharedpreferenceshelper.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferencesHelper prefs;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider(this.prefs);

  Future<void> init() async {
    final data = await SharedPreferencesHelper.loadRememberMe();
    _isLoggedIn = data['remember'] ?? false;
    notifyListeners();
  }

  Future<void> logout() async {
    await prefs.clearAll();
    _isLoggedIn = false;
    notifyListeners();
  }
}
