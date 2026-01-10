import 'package:flutter_application_1/data/models/EmployeeModel.dart';
import '../api/employee_api.dart';

class EmployeeRepository {
  Future<EmployeeModel> getEmployee(int employeeId) {
    return EmployeeApi.getProfile(employeeId);
  }
}
