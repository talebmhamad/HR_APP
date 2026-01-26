import 'dart:convert';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:http/http.dart' as http;
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';
import '../models/auth_model.dart';

class AuthApi {
  static Future<AuthModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}${ApiEndpoints.login}'),
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
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiEndpoints.deactivateUser}/$employeeId',
      ),
      headers: ApiConfig.headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to deactivate account');
    }
  }
}
