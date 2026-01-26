import 'dart:convert';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/data/models/employee_model.dart';
import 'package:http/http.dart' as http;
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';

class EmployeeApi {
  static Future<EmployeeModel> getProfile(int employeeId) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiEndpoints.employeeProfile}/$employeeId',
      ),
      headers: ApiConfig.headers(),
    );

    if (response.statusCode == 200) {
      return EmployeeModel.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException('Failed to load employee profile');
    }
  }

  static Future<void> updateProfile({
    required int employeeId,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}${ApiEndpoints.updateProfile}'),
      headers: ApiConfig.headers(),
      body: jsonEncode({
        'employeeId': employeeId,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phoneNumber,
      }),
    );

    if (response.statusCode != 200) {
      throw ApiException('Failed to update employee profile');
    }
  }
}
