class EmployeeModel {
  final int employeeId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isActive;
  final String department;
  final String phoneNumber;
  final String? profileImageUrl;

  EmployeeModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isActive,
    required this.department,
    required this.phoneNumber,
    this.profileImageUrl,
  });

  EmployeeModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    return EmployeeModel(
      employeeId: employeeId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email,
      isActive: isActive,
      department: department,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      employeeId: json['employeeId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      isActive: json['isActive'],
      department: json['department'] ?? '',
      phoneNumber: json['phone'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
