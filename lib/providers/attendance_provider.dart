import 'package:flutter/material.dart';
import '../data/models/attendance_model.dart';
import '../data/repositories/attendance_repository.dart';

class AttendanceProvider extends ChangeNotifier {
  final AttendanceRepository repository;

  AttendanceProvider(this.repository);

  List<AttendanceModel> attendances = [];
  bool isLoading = false;

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

  void clear() {
    attendances.clear();
    notifyListeners();
  }
}
