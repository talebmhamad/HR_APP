import 'package:flutter_application_1/data/models/daily_timesheet_model.dart';
import 'package:flutter_application_1/data/models/timesheet_summary_model.dart';

class TimesheetApi {
  static Future<TimesheetSummaryModel> getSummary({
    required int employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    // simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return TimesheetSummaryModel(
      totalHours: 52.5,
      daysWorked: 5,
      missingDays: 2,
      overtimeHours: 2.5,
    );
  }

  static Future<List<DailyTimesheetModel>> getDaily({
    required int employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      DailyTimesheetModel(
        date: DateTime(2026, 1, 19),
        hours: 8,
        status: 'Complete',
      ),
      DailyTimesheetModel(
        date: DateTime(2026, 1, 20),
        hours: 8,
        status: 'Complete',
      ),
      DailyTimesheetModel(
        date: DateTime(2026, 1, 21),
        hours: 6.5,
        status: 'Complete',
      ),
      DailyTimesheetModel(
        date: DateTime(2026, 1, 22),
        hours: 0,
        status: 'Absent',
      ),
      DailyTimesheetModel(
        date: DateTime(2026, 1, 23),
        hours: 0,
        status: 'Missing',
      ),
    ];
  }
}
