import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/check_in_page.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/widgets/timeclock_card.dart';

class TimeClockTab extends StatelessWidget {
  TimeClockTab({super.key});

  final List<TimeClockEntry> fakeEntries = [
    TimeClockEntry(
      date: "Mon, 23 Sep",
      timeIn: "09:00 AM",
      timeOut: "05:00 PM",
      workHours: "8h",
    ),
    TimeClockEntry(
      date: "Tue, 24 Sep",
      timeIn: "09:15 AM",
      timeOut: "05:10 PM",
      workHours: "7h 55m",
    ),
    TimeClockEntry(
      date: "Wed, 25 Sep",
      timeIn: "09:05 AM",
      timeOut: "04:45 PM",
      workHours: "7h 40m",
    ),
  ];

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

              child: ListView.builder(
                itemCount: fakeEntries.length,
                itemBuilder: (context, index) {
                  return TimeClockCard(entry: fakeEntries[index]);
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
                    "Clock in",
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
}
