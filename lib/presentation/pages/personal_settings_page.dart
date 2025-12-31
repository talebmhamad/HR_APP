import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/language_provider.dart';
import 'package:flutter_application_1/routes/route_names.dart';

import '../widgets/page_appbar.dart';
import '../widgets/setting_item.dart';
import '../widgets/user_tile.dart';
import '../widgets/language_dropdown.dart';

class PersonalSettingsPage extends StatefulWidget {
  const PersonalSettingsPage({super.key});

  @override
  State<PersonalSettingsPage> createState() => _PersonalSettingsPageState();
}

class _PersonalSettingsPageState extends State<PersonalSettingsPage> {
  final GlobalKey<PopupMenuButtonState<String>> _languageMenuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;
    final langProvider = context.watch<LanguageProvider>();

    /// SETTINGS CONFIG (Routes only)
    final List<Map<String, dynamic>> settingsList = [
      {'type': 'user'},

      {
        'type': 'item',
        'icon': Icons.notifications_none,
        'title': loc.notifications,
        'route': RouteNames.settings, // placeholder
      },
      {
        'type': 'item',
        'icon': Icons.help_outline,
        'title': loc.menuSupport,
        'route': RouteNames.settings, // placeholder
      },
      {
        'type': 'item',
        'icon': Icons.settings_applications_sharp,
        'title': loc.accountControl,
        'route': RouteNames.accountControl,
      },

      {'type': 'language'},

      {'type': 'logout', 'icon': Icons.logout, 'title': loc.logout},
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
                    name: "Test User",
                    initial: "T",
                    color: appBlue,
                    radius: w * 0.09,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.profile);
                    },
                  );
                }

                //  LANGUAGE
                if (item['type'] == 'language') {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Colors.grey,
                          size: w * 0.09,
                        ),
                        title: Text(
                          loc.language,
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          langProvider.locale.languageCode == 'en'
                              ? 'English'
                              : 'العربية',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: LanguageDropdown(
                          menuKey: _languageMenuKey,
                          dropdownColor: appBlue,
                        ),
                        onTap: () {
                          _languageMenuKey.currentState?.showButtonMenu();
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

                // ---------- LOGOUT ----------
                if (item['type'] == 'logout') {
                  return SettingItem(
                    icon: item['icon'],
                    title: item['title'],
                    onTap: () => _signOut(context),
                  );
                }

                // ---------- NORMAL ITEM ----------
                return SettingItem(
                  icon: item['icon'],
                  title: item['title'],
                  onTap: () {
                    Navigator.pushNamed(context, item['route']);
                  },
                );
              },
            ),
          ),

          //  FOOTER
          Padding(
            padding: EdgeInsets.symmetric(vertical: h * 0.03),
            child: Text(
              '${loc.version} 1.0.0.0',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  /// LOGOUT (Provider only)
  Future<void> _signOut(BuildContext context) async {
    await context.read<AuthProvider>().logout();

    Navigator.pushNamedAndRemoveUntil(context, RouteNames.login, (_) => false);
  }
}
