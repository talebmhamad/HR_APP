import 'package:flutter_application_1/data/models/employee_model.dart';
import '../api/employee_api.dart';

class EmployeeRepository {
  ///  Get employee profile
  Future<EmployeeModel> getEmployee(int employeeId) {
    return EmployeeApi.getProfile(employeeId);
  }

  ///  Update employee profile
  Future<void> updateEmployee({
    required int employeeId,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) {
    return EmployeeApi.updateProfile(
      employeeId: employeeId,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
  }
}
