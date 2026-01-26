import 'dart:convert';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:http/http.dart' as http;
import '../../core/network/api_config.dart';
import '../models/attendance_model.dart';

class AttendanceApi {
  static Future<List<AttendanceModel>> getByEmployee(int employeeId) async {
    final res = await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiEndpoints.attendanceByEmployee}/$employeeId',
      ),
      headers: ApiConfig.headers(),
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => AttendanceModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load attendance');
  }

  static Future<bool> check(AttendanceModel model) async {
    final res = await http.post(
      Uri.parse('${ApiConfig.baseUrl}${ApiEndpoints.attendanceCheck}'),
      headers: ApiConfig.headers(),
      body: jsonEncode(model.toJson()),
    );

    return res.statusCode == 200;
  }

  static Future<int> getCountToday(int employeeId) async {
    final res = await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiEndpoints.attendanceToday}/$employeeId',
      ),
      headers: ApiConfig.headers(),
    );

    if (res.statusCode == 200) {
      return int.parse(res.body);
    }

    throw Exception('Failed to get today attendance count');
  }

  static Future<double> GetTotalWorkHours(int employeeId) async {
    final res = await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiEndpoints.attendanceWorkHours}/$employeeId',
      ),
      headers: ApiConfig.headers(),
    );

    if (res.statusCode == 200) {
      return double.parse(res.body);
    }

    throw Exception('Failed to get today attendance count');
  }
}
