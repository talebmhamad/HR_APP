import 'package:flutter_application_1/data/api/auth_api.dart';
import '../models/auth_model.dart';

class AuthRepository {
  Future<AuthModel> login(String username, String password) {
    return AuthApi.login(username, password);
  }

  Future<void> deactivateAccount(int userId) async {
    await AuthApi.deactivateUser(userId);
  }
}
