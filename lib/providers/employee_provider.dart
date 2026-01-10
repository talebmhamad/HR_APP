import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/EmployeeModel.dart';
import '../data/repositories/employee_repository.dart';

class EmployeeProvider extends ChangeNotifier {
  final EmployeeRepository repository;

  EmployeeProvider(this.repository);

  EmployeeModel? employee;
  bool isLoading = false;

  Future<void> loadEmployee(int employeeId) async {
    isLoading = true;
    notifyListeners();

    try {
      employee = await repository.getEmployee(employeeId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    employee = null;
    notifyListeners();
  }
}
