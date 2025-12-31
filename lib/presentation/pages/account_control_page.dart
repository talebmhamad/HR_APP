import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/widgets/page_appbar.dart';

class AccountControlPage extends StatelessWidget {
  const AccountControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppPageAppBar(title: loc.accountControl),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  INFO TEXT
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.018,
            ),
            color: Colors.grey.shade100,
            child: Text(
              loc.accountDeleteWarning,
              style: TextStyle(color: Colors.black87, fontSize: w * 0.038),
            ),
          ),

          //  DELETE ACCOUNT ITEM
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04),
            leading: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: w * 0.065, // responsive icon size
            ),
            title: Text(
              loc.deleteAccount,
              style: TextStyle(
                color: Colors.red,
                fontSize: w * 0.045, // responsive title
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Divider(
            height: h * 0.0015,
            thickness: h * 0.0015,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
