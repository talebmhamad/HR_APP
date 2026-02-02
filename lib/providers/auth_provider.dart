import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository%20.dart';
import '../core/storage/shared_preferences_helper.dart';
import '../data/models/auth_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;
  final SharedPreferencesHelper prefs;

  AuthProvider({required this.repository, required this.prefs});

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _employeeId;
  int? get employeeId => _employeeId;

  /// Called when app starts
  Future<void> init() async {
    final data = await SharedPreferencesHelper.loadRememberMe();
    _isLoggedIn = data['remember'] ?? false;
    _employeeId = data['employeeId'];
    notifyListeners();
  }

  /// LOGIN
  Future<bool> login(String username, String password, bool rememberMe) async {
    _isLoading = true;
    notifyListeners();

    try {
      //  login via repository
      final AuthModel auth = await repository.login(username, password);

      _employeeId = auth.employeeId;
      _isLoggedIn = true;

      if (rememberMe) {
        await SharedPreferencesHelper.saveRememberMe(
          true,
          username,
          password,
          employeeId: _employeeId!,
        );
      }

      return true;
    } catch (e) {
      _isLoggedIn = false;
      _employeeId = null;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await prefs.clearAll();
    _isLoggedIn = false;
    _employeeId = null;
    notifyListeners();
  }

  /// DELETE / DEACTIVATE ACCOUNT
  Future<bool> deleteAccount() async {
    if (_employeeId == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await repository.deactivateAccount(_employeeId!);
      await logout();
      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
