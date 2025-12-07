// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/services/SharedPreferencesHelper.dart';
import '../services/authservice.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const LoginPage({super.key, required this.onLocaleChange});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPass = false;
  bool rememberMe = false;
  String _selectedLanguage = 'العربية (AR)';

  final Map<String, String> _languagesMap = {
    'English (US)': 'en',
    'العربية (AR)': 'ar',
  };

  late Map<String, String> _codeToLabel;

  Future<void> _loadRememberMePreference() async {
    var data = await SharedPreferencesHelper.loadRememberMe();

    setState(() {
      rememberMe = data["remember"];
    });

    if (rememberMe) {
      _emailController.text = data["username"];
      _passwordController.text = data["password"];
    }
  }

  // SAVE Remember Me + Credentials
  Future<void> _saveRememberMePreference(bool value) async {
    await SharedPreferencesHelper.saveRememberMe(
      value,
      _emailController.text,
      _passwordController.text,
    );
  }

  Future<void> _loadSavedLanguage() async {
    String? saved = await SharedPreferencesHelper.loadLanguage();

    if (saved != null && _codeToLabel.containsKey(saved)) {
      setState(() {
        _selectedLanguage = _codeToLabel[saved]!;
      });
    }
  }

  @override
  @override
  void initState() {
    super.initState();

    _codeToLabel = _languagesMap.map((label, code) => MapEntry(code, label));

    _loadSavedLanguage();
    _loadRememberMePreference();
  }

  Future<void> _login() async {
    bool success = await ApiService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      // Load saved language
      String? lang = await SharedPreferencesHelper.loadLanguage();

      if (lang != null) {
        widget.onLocaleChange(Locale(lang));
      }

      // Navigate to home
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: h * 0.30,
              decoration: BoxDecoration(
                color: appBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.05),

                  // LANGUAGE DROPDOWN
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.08, top: h * 0.01),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white70,
                        ),
                        dropdownColor: appBlue,
                        underline: Container(),
                        style: TextStyle(
                          fontSize: w * 0.04,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),

                        // SAME STYLE – only changed source .keys
                        items: _languagesMap.keys.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(
                              lang,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.04,
                              ),
                            ),
                          );
                        }).toList(),

                        onChanged: (val) async {
                          setState(() => _selectedLanguage = val!);

                          // Get code from map
                          String localeCode = _languagesMap[val]!;

                          // Save to SharedPreferences
                          await SharedPreferencesHelper.saveLanguage(
                            localeCode,
                          );

                          // Update whole app UI immediately
                          widget.onLocaleChange(Locale(localeCode));
                        },
                      ),
                    ),
                  ),

                  // TITLE
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.intracore,
                          style: TextStyle(
                            fontSize: w * 0.08,
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                ],
              ),
            ),

            SizedBox(height: h * 0.05),

            // WELCOME BACK TEXT
            Text(
              AppLocalizations.of(context)!.welcomeBack,
              style: TextStyle(
                fontSize: w * 0.06,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: h * 0.04),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.08),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // USERNAME FIELD
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.username,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                        fillColor: Colors.grey.shade50,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: appBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "${AppLocalizations.of(context)!.username} is required";
                        }
                        if (v.length < 5) {
                          return "${AppLocalizations.of(context)!.username} must be at least 5 characters";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: h * 0.03),

                    // PASSWORD FIELD
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_showPass,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                        fillColor: Colors.grey.shade50,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: appBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () {
                            setState(() => _showPass = !_showPass);
                          },
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "${AppLocalizations.of(context)!.password} is required";
                        }
                        if (v.length < 8) {
                          return "${AppLocalizations.of(context)!.password} must be at least 8 characters";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: h * 0.03),

                    // REMEMBER ME + FORGOT PASSWORD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (v) {
                                setState(() => rememberMe = v!);
                              },
                              activeColor: appBlue,
                              checkColor: Colors.white,
                            ),
                            Text(
                              AppLocalizations.of(context)!.rememberMe,
                              style: TextStyle(
                                fontSize: w * 0.038,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.forgotPassword,
                            style: TextStyle(
                              fontSize: w * 0.038,
                              color: appBlue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.04),

                    // LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: h * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            fontSize: w * 0.05,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
