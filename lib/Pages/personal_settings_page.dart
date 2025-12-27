import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/account_control_page.dart';
import 'package:flutter_application_1/Pages/user_profile_page.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/core/storage/sharedpreferenceshelper.dart';
import 'package:flutter_application_1/widgets/language_dropdown.dart';
import 'package:flutter_application_1/providers/language_provider.dart';
import 'package:flutter_application_1/widgets/page_appbar.dart';
import 'package:provider/provider.dart';

import '../widgets/settingitem.dart';
import '../widgets/user_tile.dart';

class PersonalSettingsPage extends StatefulWidget {
  const PersonalSettingsPage({super.key});

  @override
  State<PersonalSettingsPage> createState() => _PersonalSettingsPageState();
}

class _PersonalSettingsPageState extends State<PersonalSettingsPage> {
  final GlobalKey<PopupMenuButtonState<String>> languageMenuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;
    final provider = Provider.of<LanguageProvider>(context);

    //  SETTINGS LIST
    final List<Map<String, dynamic>> settingsList = [
      {'type': 'user'},

      {
        'type': 'item',
        'icon': Icons.notifications_none,
        'title': loc.notifications,
        'destination': Container(),
      },

      {
        'type': 'item',
        'icon': Icons.help_outline,
        'title': loc.menuSupport,
        'destination': Container(),
      },
      {
        'type': 'item',
        'icon': Icons.settings_applications_sharp,
        'title': loc.accountControl,
        'destination': AccountControlPage(),
      },
      // ADD THIS LANGUAGE ITEM HERE
      {'type': 'language', 'icon': Icons.language, 'title': loc.language},
      //  LOGOUT
      {
        'type': 'item',
        'icon': Icons.logout,
        'title': loc.logout,
        'onTap': () => _signOut(context),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppPageAppBar(title: loc.menuPersonalSettings),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: settingsList.length,
              itemBuilder: (context, index) {
                final item = settingsList[index];

                //  USER TILE
                if (item['type'] == 'user') {
                  return UserTile(
                    name: "Test",
                    initial: "T",
                    color: appBlue,
                    destination: const UserProfilePage(),
                    radius: w * 0.09,
                  );
                }
                // 2. ADD THE LANGUAGE UI LOGIC HERE
                if (item['type'] == 'language') {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          item['icon'],
                          color: Colors.grey,
                          size: w * 0.09,
                        ),
                        title: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          provider.locale.languageCode == 'en'
                              ? 'English'
                              : 'العربية',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: LanguageDropdown(
                          menuKey: languageMenuKey,
                          dropdownColor: appBlue,
                        ),
                        onTap: () {
                          languageMenuKey.currentState?.showButtonMenu();
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  );
                }

                //  NORMAL SETTINGS ITEM
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
            child: Text(
              '${loc.version} 1.0.0.0',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // SIGN OUT
  void _signOut(BuildContext context) {
    SharedPreferencesHelper.clearAll();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
