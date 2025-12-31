import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/dashboard_utils.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class WhoInOutCard extends StatelessWidget {
  const WhoInOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: cardDecoration(),
      child: Column(
        children: [
          buildCardHeader(loc.whosInOut),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildStat("0", loc.inLabel),
                buildStat("0", loc.breakLabel),
                buildStat("1", loc.outLabel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}
