import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'home_tab.dart';
import 'timeclock_tab.dart';
import 'timesheets_tab.dart';
import 'approvals_tab.dart';
import 'menu_tab.dart';

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
    ApprovalsTab(),
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

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Time Clock"),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_outlined),
            label: "Timesheets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_outlined),
            label: "Approvals",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }
}
