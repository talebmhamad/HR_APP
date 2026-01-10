import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/row_chekin.dart';
import 'package:flutter_application_1/providers/attendance_provider.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final TextEditingController noteController = TextEditingController();
  late String date;
  late String time;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    date = DateFormat('EEEE, d MMMM yyyy').format(now);
    time = DateFormat('hh:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        title: Text(
          loc.confirm,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Consumer<EmployeeProvider>(
                          builder: (context, employeeProvider, _) {
                            final employee = employeeProvider.employee;
                            return RowCheckIn(
                              icon: Icons.person_outline,
                              label: loc.employee,
                              value: employee != null
                                  ? '${employee.firstName} ${employee.lastName}'
                                  : '-',
                            );
                          },
                        ),

                        const Divider(height: 30, thickness: 0.8),

                        RowCheckIn(
                          icon: Icons.calendar_today_outlined,
                          label: loc.date,
                          value: date,
                        ),

                        const Divider(height: 30, thickness: 0.8),

                        RowCheckIn(
                          icon: Icons.access_time_rounded,
                          label: loc.Time,
                          value: time,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    loc.addNote,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: noteController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: loc.hintnote,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: context.watch<AttendanceProvider>().isLoading
                    ? null
                    : () async {
                        final employee = context
                            .read<EmployeeProvider>()
                            .employee;
                        if (employee == null) return;
                        final success = await context
                            .read<AttendanceProvider>()
                            .check(employee.employeeId);
                        if (success && mounted) {
                          Navigator.pop(context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  loc.confirm,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
