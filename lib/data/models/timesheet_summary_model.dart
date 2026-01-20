class TimesheetSummaryModel {
  final double totalHours;
  final int daysWorked;
  final int missingDays;
  final double overtimeHours;

  TimesheetSummaryModel({
    required this.totalHours,
    required this.daysWorked,
    required this.missingDays,
    required this.overtimeHours,
  });
}
