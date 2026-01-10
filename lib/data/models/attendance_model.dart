class AttendanceModel {
  final int attendanceId;
  final int employeeId;
  final String employeeName;
  final DateTime attendanceDate;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String status;

  AttendanceModel({
    required this.attendanceId,
    required this.employeeId,
    required this.employeeName,
    required this.attendanceDate,
    this.checkInTime,
    this.checkOutTime,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      attendanceId: json['attendanceId'],
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      attendanceDate: DateTime.parse(json['attendanceDate']),
      checkInTime: json['checkInTime'] != null
          ? DateTime.parse(json['checkInTime'])
          : null,
      checkOutTime: json['checkOutTime'] != null
          ? DateTime.parse(json['checkOutTime'])
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'attendanceDate': attendanceDate.toIso8601String(),
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'status': status,
    };
  }
}
