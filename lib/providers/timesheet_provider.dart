import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/timesheet_repository%20.dart';
import '../data/models/timesheet_summary_model.dart';
import '../data/models/daily_timesheet_model.dart';

class TimesheetProvider extends ChangeNotifier {
  final TimesheetRepository repository;

  TimesheetProvider(this.repository);

  //  STATE
  String _period = 'week';
  bool isLoading = false;

  TimesheetSummaryModel? summary;
  List<DailyTimesheetModel> dailyList = [];

  String get period => _period;

  //  PERIOD CHANGE
  Future<void> changePeriod({
    required int employeeId,
    required String value,
  }) async {
    _period = value;
    await loadTimesheet(employeeId: employeeId);
  }

  //  LOAD DATA
  Future<void> loadTimesheet({required int employeeId}) async {
    isLoading = true;
    notifyListeners();

    try {
      final now = DateTime.now();
      late DateTime startDate;
      late DateTime endDate;

      //  Date logic based on period
      switch (_period) {
        case 'week':
          startDate = now.subtract(Duration(days: now.weekday - 1));
          endDate = startDate.add(const Duration(days: 6));
          break;

        case 'month':
          startDate = DateTime(now.year, now.month, 1);
          endDate = DateTime(now.year, now.month + 1, 0);
          break;

        default:
          startDate = now;
          endDate = now;
      }

      //  Repository calls
      summary = await repository.getSummary(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );

      dailyList = await repository.getDaily(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      debugPrint('TimesheetProvider error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  CLEAR
  void clear() {
    summary = null;
    dailyList.clear();
    notifyListeners();
  }
}
