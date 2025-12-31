import 'package:flutter_application_1/presentation/pages/account_control_page.dart';
import 'package:flutter_application_1/presentation/pages/check_in_page.dart';
import 'package:flutter_application_1/presentation/pages/personal_settings_page.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/main_home_page.dart';
import 'route_names.dart';

class AppRoutes {
  static final routes = {
    RouteNames.login: (_) => const LoginPage(),
    RouteNames.home: (_) => const MainHomePage(),
    RouteNames.checkIn: (_) => const CheckInPage(),
    RouteNames.settings: (_) => const PersonalSettingsPage(),
    RouteNames.accountControl: (_) => const AccountControlPage(),
    RouteNames.profile: (_) => const UserProfilePage(),
  };
}
