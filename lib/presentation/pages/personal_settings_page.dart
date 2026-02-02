import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/logout_confirm_dialog.dart';
import 'package:flutter_application_1/presentation/widgets/theme_dropdown.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/language_provider.dart';
import 'package:flutter_application_1/routes/route_names.dart';

import '../widgets/page_appbar.dart';
import '../widgets/setting_item.dart';
import '../widgets/user_title.dart';
import '../widgets/language_dropdown.dart';

class PersonalSettingsPage extends StatefulWidget {
  const PersonalSettingsPage({super.key});

  @override
  State<PersonalSettingsPage> createState() => _PersonalSettingsPageState();
}

class _PersonalSettingsPageState extends State<PersonalSettingsPage> {
  final GlobalKey<PopupMenuButtonState<String>> _languageMenuKey = GlobalKey();
  final GlobalKey<PopupMenuButtonState<String>> _themeMenuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;
    final langProvider = context.watch<LanguageProvider>();

    /// SETTINGS CONFIG
    final List<Map<String, dynamic>> settingsList = [
      {'type': 'user'},

      {
        'type': 'item',
        'icon': Icons.notifications_none,
        'title': loc.notifications,
        'route': RouteNames.settings,
      },
      {
        'type': 'item',
        'icon': Icons.help_outline,
        'title': loc.menuSupport,
        'route': RouteNames.settings,
        'showArrow': false,
      },
      {
        'type': 'item',
        'icon': Icons.settings_applications_sharp,
        'title': loc.accountControl,
        'route': RouteNames.accountControl,
        'showArrow': true,
      },

      {'type': 'language'},

      {'type': 'theme'},

      {'type': 'logout', 'icon': Icons.logout, 'title': loc.logout},
    ];

    return Scaffold(
      appBar: AppPageAppBar(title: loc.menuPersonalSettings),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: settingsList.length,
              itemBuilder: (context, index) {
                final item = settingsList[index];

                // USER TILE
                if (item['type'] == 'user') {
                  return Consumer<EmployeeProvider>(
                    builder: (context, employeeProvider, _) {
                      final emp = employeeProvider.employee;

                      if (emp == null) {
                        return const SizedBox();
                      }

                      return UserTile(
                        name: '${emp.firstName} ${emp.lastName}',
                        initial: emp.firstName.isNotEmpty
                            ? emp.firstName[0].toUpperCase()
                            : '?',
                        color: appBlue,
                        radius: w * 0.09,
                        imagePath: emp.profileImageUrl,
                        showArrow: true,
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.profile);
                        },
                      );
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
                      Divider(height: 1, thickness: 1),
                    ],
                  );
                }
                // ---------- THEME ----------
                if (item['type'] == 'theme') {
                  final themeProvider = context.watch<ThemeProvider>();

                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.grey,
                          size: w * 0.09,
                        ),
                        title: Text(
                          'Theme',
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          themeProvider.isDark ? 'Dark' : 'Light',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: ThemeDropdown(menuKey: _themeMenuKey),
                        onTap: () {
                          _themeMenuKey.currentState?.showButtonMenu();
                        },
                      ),
                      Divider(height: 1, thickness: 1),
                    ],
                  );
                }

                // ---------- LOGOUT ----------
                if (item['type'] == 'logout') {
                  return SettingItem(
                    icon: item['icon'],
                    title: item['title'],
                    showArrow: true,
                    onTap: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (_) => const LogoutConfirmDialog(),
                      );

                      if (confirmed != true) return;

                      _signOut(context);
                    },
                  );
                }

                // ---------- NORMAL ITEM ----------
                return SettingItem(
                  icon: item['icon'],
                  title: item['title'],
                  onTap: () {
                    Navigator.pushNamed(context, item['route']);
                  },
                  showArrow: item['showArrow'] ?? false,
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

  /// LOGOUT
  Future<void> _signOut(BuildContext context) async {
    await context.read<AuthProvider>().logout();

    Navigator.pushNamedAndRemoveUntil(context, RouteNames.login, (_) => false);
  }
}
