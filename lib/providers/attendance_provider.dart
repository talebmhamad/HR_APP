import 'package:flutter/material.dart';
import '../data/models/attendance_model.dart';
import '../data/repositories/attendance_repository.dart';

class AttendanceProvider extends ChangeNotifier {
  final AttendanceRepository repository;

  AttendanceProvider(this.repository);

  List<AttendanceModel> attendances = [];
  bool isLoading = false;
  int todayCount = 0;
  double totalWorkHours = 0.0;
  //  Load Attendance
  Future<void> loadByEmployee(int employeeId) async {
    isLoading = true;
    notifyListeners();

    try {
      attendances = await repository.getByEmployee(employeeId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  Check In / Check Out
  Future<bool> check(int employeeId) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = AttendanceModel(
        attendanceId: 0,
        employeeId: employeeId,
        employeeName: '',
        attendanceDate: DateTime.now(),
        checkInTime: null,
        checkOutTime: null,
        status: 'Present',
      );

      final success = await repository.check(model);

      if (success) {
        await loadByEmployee(employeeId);
      }

      return success;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTodayCount(int employeeId) async {
    todayCount = await repository.getCountToday(employeeId);
    notifyListeners();
  }

  Future<void> GetTotalWorkHours(int employeeId) async {
    totalWorkHours = await repository.GetTotalWorkHours(employeeId);
    notifyListeners();
  }

  void clear() {
    attendances.clear();
    notifyListeners();
  }

  AttendanceModel? get todayOpenAttendance {
    final today = DateTime.now();

    try {
      return attendances.firstWhere(
        (a) =>
            a.attendanceDate.year == today.year &&
            a.attendanceDate.month == today.month &&
            a.attendanceDate.day == today.day &&
            a.checkInTime != null &&
            a.checkOutTime == null,
      );
    } catch (_) {
      return null;
    }
  }

  int get inToday => todayCount == 1 ? 1 : 0;
  int get outToday => todayCount == 0 ? 1 : 0;
  int get breakToday => 0;
  bool get isCheckedInToday => todayOpenAttendance != null;
}
