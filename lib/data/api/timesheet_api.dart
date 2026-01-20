import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/network/api_config.dart';
import '../models/timesheet_summary_model.dart';
import '../models/daily_timesheet_model.dart';

class TimesheetApi {
  static Future<TimesheetSummaryModel> getSummary({
    required int employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/timesheets/summary'
      '?employeeId=$employeeId'
      '&startDate=${startDate.toIso8601String()}'
      '&endDate=${endDate.toIso8601String()}',
    );

    final res = await http.get(uri, headers: ApiConfig.headers());

    if (res.statusCode != 200) {
      throw Exception('Failed to load timesheet summary');
    }

    final data = jsonDecode(res.body);
    return TimesheetSummaryModel(
      totalHours: (data['totalHours'] as num).toDouble(),
      daysWorked: data['daysWorked'],
      missingDays: data['missingDays'],
      overtimeHours: (data['overtimeHours'] as num).toDouble(),
    );
  }

  static Future<List<DailyTimesheetModel>> getDaily({
    required int employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/timesheets/daily'
      '?employeeId=$employeeId'
      '&startDate=${startDate.toIso8601String()}'
      '&endDate=${endDate.toIso8601String()}',
    );

    final res = await http.get(uri, headers: ApiConfig.headers());

    if (res.statusCode != 200) {
      throw Exception('Failed to load daily timesheets');
    }

    final List data = jsonDecode(res.body);
    return data
        .map(
          (e) => DailyTimesheetModel(
            date: DateTime.parse(e['date']),
            hours: (e['hours'] as num).toDouble(),
            status: e['status'],
          ),
        )
        .toList();
  }
}
