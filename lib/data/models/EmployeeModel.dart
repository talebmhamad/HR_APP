class EmployeeModel {
  final int employeeId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isActive;
  final String department;
  final String phoneNumber;

  EmployeeModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isActive,
    required this.department,
    required this.phoneNumber,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      employeeId: json['employeeId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      isActive: json['isActive'],
      department: json['department'] ?? '',
      phoneNumber: json['phone'] ?? '',
    );
  }
}
