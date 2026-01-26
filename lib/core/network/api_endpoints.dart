class ApiEndpoints {
  //  Auth
  static const login = '/api/auth/login';
  static const deactivateUser = '/api/user/deactivate';

  //  Employee
  static const employeeProfile = '/api/employee/profile';
  static const updateProfile = '/api/employee/update-profile';

  //  Attendance
  static const attendanceByEmployee = '/api/attendance/employee';
  static const attendanceCheck = '/api/attendance/check';
  static const attendanceToday = '/api/attendance/today';
  static const attendanceWorkHours = '/api/attendance/workhours';

  //  Timesheet
  static const timesheetSummary = '/api/timesheets/summary';
  static const timesheetDaily = '/api/timesheets/daily';
}
