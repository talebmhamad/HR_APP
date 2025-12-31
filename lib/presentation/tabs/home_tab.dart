import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/chart_card.dart';
import 'package:flutter_application_1/presentation/widgets/trackedhours_card.dart';
import 'package:flutter_application_1/presentation/widgets/who_in_out_card.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          loc.Dashboard,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(w * 0.04),
        itemCount: 4,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const WhoInOutCard();
            case 1:
              return const TrackedHoursCard();
            case 2:
              return ChartCard(title: loc.projects);
            case 3:
              return ChartCard(title: loc.activities);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
