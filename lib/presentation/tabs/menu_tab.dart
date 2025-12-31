import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/personal_settings_page.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/routes/route_names.dart';

import '../../widgets/SettingItem.dart';
import '../widgets/user_tile.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> menuList = [
      {
        "type": "section",
        "title": AppLocalizations.of(context)!.menuOrganization,
      },
      {"type": "user"},

      {"type": "section", "title": AppLocalizations.of(context)!.menuOverview},
      {
        "type": "item",
        "icon": Icons.work_outline,
        "title": AppLocalizations.of(context)!.menuTimeOff,
        "route": RouteNames.settings,
      },

      {"type": "section", "title": AppLocalizations.of(context)!.menuAccount},
      {
        "type": "item",
        "icon": Icons.person_outline,
        "title": AppLocalizations.of(context)!.menuPersonalSettings,
        "route": RouteNames.settings,
      },

      {"type": "section", "title": AppLocalizations.of(context)!.menuHelp},
      {
        "type": "item",
        "icon": Icons.help_outline,
        "title": AppLocalizations.of(context)!.menuSupport,
        "route": RouteNames.settings,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.menuMore,
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          final item = menuList[index];

          // SECTION HEADER
          if (item["type"] == "section") {
            return Padding(
              padding: EdgeInsets.only(
                bottom: h * 0.005,
                top: h * 0.02,
                left: w * 0.05,
                right: w * 0.05,
              ),
              child: Text(
                item["title"],
                style: const TextStyle(
                  color: Color.fromARGB(137, 5, 5, 5),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          // USER TILE
          if (item["type"] == "user") {
            return UserTile(
              name: "Erpuim",
              initial: "E",
              color: appBlue,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.profile);
              },
              radius: w * 0.07,
            );
          }

          // NORMAL MENU ITEM
          SettingItem(
            icon: item["icon"],
            title: item["title"],
            onTap: () {
              Navigator.pushNamed(context, item["route"]);
            },
          );
        },
      ),
    );
  }
}
