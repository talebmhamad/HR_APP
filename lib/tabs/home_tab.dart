import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.Dashboard,
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.black, // Title color
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: w * 0.04),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: appBlue,
              child: const Text("T", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Divider(height: 1, thickness: 1),

          //  Main Content Below
          Expanded(
            child: Center(
              child: Text(
                "Welcome to Dashboard",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
