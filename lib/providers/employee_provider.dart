import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/employee_model.dart';
import '../data/repositories/employee_repository.dart';

class EmployeeProvider extends ChangeNotifier {
  final EmployeeRepository repository;

  EmployeeProvider(this.repository);

  EmployeeModel? employee;
  bool isLoading = false;

  ///  Load employee profile
  Future<void> loadEmployee(int employeeId) async {
    isLoading = true;
    notifyListeners();

    try {
      employee = await repository.getEmployee(employeeId);
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///  Update profile info
  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    if (employee == null) return;

    isLoading = true;
    notifyListeners();

    try {
      await repository.updateEmployee(
        employeeId: employee!.employeeId,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );

      //  Update local state (no re-fetch needed)
      employee = employee!.copyWith(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///  Clear employee (logout, session end)
  void clear() {
    employee = null;
    notifyListeners();
  }
}
