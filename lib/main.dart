import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/main_home_page.dart';
import 'features/auth/presentation/login_page.dart';
import 'l10n/app_localizations.dart';
import 'providers/language_provider.dart';
import 'core/storage/sharedpreferenceshelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final rememberData = await SharedPreferencesHelper.loadRememberMe();
  final bool remember = rememberData["remember"] ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: MyApp(isLoggedIn: remember),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //  Localization
      locale: langProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      //  SAFE BOOT SCREEN
      home: isLoggedIn ? const MainHomePage() : const LoginPage(),

      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const MainHomePage(),
      },
    );
  }
}
