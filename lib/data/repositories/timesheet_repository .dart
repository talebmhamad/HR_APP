import '../api/timesheet_api.dart';
import '../models/timesheet_summary_model.dart';
import '../models/daily_timesheet_model.dart';

class TimesheetRepository {
  Future<TimesheetSummaryModel> getSummary({
    required int employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return TimesheetApi.getSummary(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<List<DailyTimesheetModel>> getDaily({
    required int employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return TimesheetApi.getDaily(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
