import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository%20.dart';
import 'package:flutter_application_1/data/repositories/timesheet_repository%20.dart';
import 'package:flutter_application_1/data/repositories/attendance_repository.dart';
import 'package:flutter_application_1/data/repositories/employee_repository.dart';
import 'package:flutter_application_1/providers/attendance_provider.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/providers/timesheet_provider.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'providers/language_provider.dart';
import 'core/storage/shared_preferences_helper.dart';
import 'routes/route_names.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = SharedPreferencesHelper();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              AuthProvider(repository: AuthRepository(), prefs: prefs)..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(EmployeeRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => AttendanceProvider(AttendanceRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => TimesheetProvider(TimesheetRepository()),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<LanguageProvider, AuthProvider, ThemeProvider>(
      builder: (context, langProvider, authProvider, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          //  Language
          locale: langProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          //  Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,

          //  Auth routing
          initialRoute: authProvider.isLoggedIn
              ? RouteNames.home
              : RouteNames.login,

          routes: AppRoutes.routes,
        );
      },
    );
  }
}
