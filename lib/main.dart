import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/AuthRepository%20.dart';
import 'package:flutter_application_1/data/repositories/attendance_repository.dart';
import 'package:flutter_application_1/data/repositories/employee_repository.dart';
import 'package:flutter_application_1/providers/attendance_provider.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'providers/language_provider.dart';
import 'core/storage/sharedpreferenceshelper.dart';
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    final authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: langProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      initialRoute: authProvider.isLoggedIn
          ? RouteNames.home
          : RouteNames.login,

      routes: AppRoutes.routes,
    );
  }
}
