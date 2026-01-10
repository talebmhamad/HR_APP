import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/pages/check_in_page.dart';
import 'package:flutter_application_1/presentation/widgets/timeclock_card.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/attendance_provider.dart';

class TimeClockTab extends StatefulWidget {
  const TimeClockTab({super.key});

  @override
  State<TimeClockTab> createState() => _TimeClockTabState();
}

class _TimeClockTabState extends State<TimeClockTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();
      final attendance = context.read<AttendanceProvider>();

      if (auth.employeeId != null) {
        attendance.loadByEmployee(auth.employeeId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          loc.menuTimeClock,
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Consumer<AttendanceProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.attendances.isEmpty) {
                    return const Center(child: Text("No attendance records"));
                  }

                  return ListView.builder(
                    itemCount: provider.attendances.length,
                    itemBuilder: (context, index) {
                      final a = provider.attendances[index];

                      return TimeClockCard(
                        entry: TimeClockEntry(
                          date: _formatDate(a.attendanceDate),
                          timeIn: a.checkInTime != null
                              ? _formatTime(a.checkInTime!)
                              : '-',
                          timeOut: a.checkOutTime != null
                              ? _formatTime(a.checkOutTime!)
                              : '-',
                          workHours: _calcWorkHours(
                            a.checkInTime,
                            a.checkOutTime,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Positioned(
              right: 24,
              bottom: 28,
              child: SizedBox(
                width: w * 0.40,
                height: h * 0.060,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CheckInPage()),
                    );
                  },
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  label: const Text(
                    "Check",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  String _calcWorkHours(DateTime? inTime, DateTime? outTime) {
    if (inTime == null || outTime == null) return '-';

    final diff = outTime.difference(inTime);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;

    return "${hours}h ${minutes}m";
  }
}
