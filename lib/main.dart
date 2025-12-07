import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/main_home_page.dart';
import 'package:flutter_application_1/Pages/login_page.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/services/sharedpreferenceshelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? savedLang = await SharedPreferencesHelper.loadLanguage();

  runApp(
    MyApp(
      initialLocale: savedLang != null ? Locale(savedLang) : const Locale('ar'),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

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

      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(onLocaleChange: setLocale),
        '/home': (context) => MainHomePage(),
      },
    );
  }
}
