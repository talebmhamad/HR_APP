import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/services/SharedPreferencesHelper.dart';

import '../widgets/settingitem.dart';
import '../widgets/user_tile.dart';

class PersonalSettingsPage extends StatelessWidget {
  const PersonalSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // --- SETTINGS LIST ---
    final List<Map<String, dynamic>> settingsList = [
      {'type': 'user'},

      {
        'type': 'item',
        'icon': Icons.notifications_none,
        'title': 'notifications',
        'destination': Container(),
      },
      {
        'type': 'item',
        'icon': Icons.settings_outlined,
        'title': 'preferences',
        'destination': Container(),
      },
      {
        'type': 'item',
        'icon': Icons.help_outline,
        'title': AppLocalizations.of(context)!.menuSupport,
        'destination': Container(),
      },
      {
        'type': 'item',
        'icon': Icons.settings_applications_sharp,
        'title': 'accountControl',
        'destination': Container(),
      },

      // --- LOGOUT ---
      {
        'type': 'item',
        'icon': Icons.logout,
        'title': "logout",
        'onTap': () => _signOut(context),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      // --- APP BAR ---
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.menuPersonalSettings,
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: settingsList.length,
              itemBuilder: (context, index) {
                final item = settingsList[index];

                // --- USER TILE ---
                if (item['type'] == 'user') {
                  return UserTile(
                    name: "Test",
                    initial: "T",
                    color: appBlue,
                    destination: const PersonalSettingsPage(),
                    radius: w * 0.05, // small avatar for settings page
                  );
                }

                // --- NORMAL SETTINGS ITEM ---
                return SettingItem(
                  icon: item['icon'],
                  title: item['title'],
                  destination: item['destination'],
                  onTap: item['onTap'],
                );
              },
            ),
          ),

          // --- FOOTER VERSION ---
          Padding(
            padding: EdgeInsets.only(bottom: h * 0.03, top: h * 0.03),
            child: const Text(
              "Version 1.0.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // --- SIGN OUT ---
  void _signOut(BuildContext context) async {
    final ctx = context;

    await SharedPreferencesHelper.clearAll();

    Navigator.pushNamedAndRemoveUntil(ctx, '/login', (route) => false);
  }
}
