import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/network/api_config.dart';
import '../models/attendance_model.dart';

class AttendanceApi {
  static Future<List<AttendanceModel>> getByEmployee(int employeeId) async {
    final res = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/attendance/employee/$employeeId'),
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
      Uri.parse('${ApiConfig.baseUrl}/api/attendance/check'),
      headers: ApiConfig.headers(),
      body: jsonEncode(model.toJson()),
    );

    return res.statusCode == 200;
  }
}
