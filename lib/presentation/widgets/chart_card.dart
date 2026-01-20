import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'dashboard_utils.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class ChartCard extends StatelessWidget {
  final String title;
  const ChartCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

    return Consumer<AttendanceProvider>(
      builder: (context, provider, _) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: cardDecoration(),
          child: Column(
            children: [
              buildCardHeader(title),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: w * 0.5,
                      height: w * 0.5,
                      child: CircularProgressIndicator(
                        value: 0.7,
                        strokeWidth: 35,
                        color: Colors.grey.shade300,
                        backgroundColor: Colors.grey.shade100,
                      ),
                    ),
                    Text(
                      provider.totalWorkHours > 0
                          ? '${provider.totalWorkHours.toStringAsFixed(1)} h'
                          : loc.noDataFor(title),

                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
