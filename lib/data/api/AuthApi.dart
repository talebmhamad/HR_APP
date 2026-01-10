import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';
import '../models/auth_model.dart';

class AuthApi {
  static Future<AuthModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/auth/login'),
      headers: ApiConfig.headers(),
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException('Invalid username or password');
    }
  }

  static Future<void> deactivateUser(int employeeId) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/User/deactivate/$employeeId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to deactivate account');
    }
  }
}
