import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/main_home_page.dart';
import 'package:flutter_application_1/Features/auth/presentation/login_page.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/core/storage/sharedpreferenceshelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved language
  String? savedLang = await SharedPreferencesHelper.loadLanguage();

  // Load remember me data
  Map<String, dynamic> rememberData =
      await SharedPreferencesHelper.loadRememberMe();
  bool remember = rememberData["remember"] ?? false;

  // Decide which page to start with
  String initialRoute = remember ? '/home' : '/login';

  runApp(
    MyApp(
      initialLocale: savedLang != null ? Locale(savedLang) : const Locale('ar'),
      initialRoute: initialRoute,
    ),
  );
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;
  final String initialRoute;

  const MyApp({
    super.key,
    required this.initialLocale,
    required this.initialRoute,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _appLocale;

  @override
  void initState() {
    super.initState();
    _appLocale = widget.initialLocale;
  }

  void setLocale(Locale locale) {
    setState(() {
      _appLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: _appLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      home: widget.initialRoute == '/home'
          ? MainHomePage()
          : LoginPage(onLocaleChange: setLocale),

      routes: {
        '/login': (context) => LoginPage(onLocaleChange: setLocale),
        '/home': (context) => MainHomePage(),
      },
    );
  }
}
