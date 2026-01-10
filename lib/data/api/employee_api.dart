import 'dart:convert';
import 'package:flutter_application_1/data/models/EmployeeModel.dart';
import 'package:http/http.dart' as http;
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';

class EmployeeApi {
  static Future<EmployeeModel> getProfile(int employeeId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/employee/profile/$employeeId'),
      headers: ApiConfig.headers(),
    );

    if (response.statusCode == 200) {
      return EmployeeModel.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException('Failed to load employee profile');
    }
  }
}
