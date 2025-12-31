import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/tabs/menu_tab.dart';
import '../tabs/home_tab.dart';
import '../tabs/timeclock_tab.dart';
import '../tabs/timesheets_tab.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    TimeClockTab(),
    TimesheetsTab(),
    MenuTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: appBlue,
        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed, // important for 5 items
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.menuHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timer),
            label: AppLocalizations.of(context)!.menuTimeClock,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.insert_drive_file_outlined),
            label: AppLocalizations.of(context)!.menuTimesheets,
          ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.menu),
            label: AppLocalizations.of(context)!.menuMore,
          ),
        ],
      ),
    );
  }
}
