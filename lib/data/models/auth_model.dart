class AuthModel {
  final int employeeId;

  AuthModel({required this.employeeId});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(employeeId: json['employeeId']);
  }
}
