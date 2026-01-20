import '../api/attendance_api.dart';
import '../models/attendance_model.dart';

class AttendanceRepository {
  Future<List<AttendanceModel>> getByEmployee(int employeeId) {
    return AttendanceApi.getByEmployee(employeeId);
  }

  Future<bool> check(AttendanceModel model) {
    return AttendanceApi.check(model);
  }

  Future<int> getCountToday(int employeeId) {
    return AttendanceApi.getCountToday(employeeId);
  }

  Future<double> GetTotalWorkHours(int employeeId) {
    return AttendanceApi.GetTotalWorkHours(employeeId);
  }
}
