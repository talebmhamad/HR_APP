import 'package:flutter/material.dart';

class TimeClockEntry {
  final String date;
  final String timeIn;
  final String timeOut;
  final String workHours;

  TimeClockEntry({
    required this.date,
    required this.timeIn,
    required this.timeOut,
    required this.workHours,
  });
}

class TimeClockCard extends StatelessWidget {
  final TimeClockEntry entry;

  const TimeClockCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DATE
          Text(
            entry.date,
            style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("Time In", entry.timeIn),
              _info("Time Out", entry.timeOut),
              _info("Hours", entry.workHours),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
