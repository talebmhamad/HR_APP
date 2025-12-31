// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/core/storage/sharedpreferenceshelper.dart';
import '../../data/api/AuthApi.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/providers/language_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPass = false;
  bool rememberMe = false;

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

  @override
  void initState() {
    super.initState();
    _loadRememberMePreference();
  }

  Future<void> _login() async {
    bool success = await ApiService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      await SharedPreferencesHelper.saveRememberMe(
        rememberMe,
        _emailController.text,
        _passwordController.text,
      );

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

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

                  // ===== LANGUAGE DROPDOWN (PROVIDER) =====
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.08, top: h * 0.01),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Consumer<LanguageProvider>(
                        builder: (context, provider, _) {
                          return DropdownButton<String>(
                            value: provider.locale.languageCode,
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
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text(
                                  'English (US)',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'ar',
                                child: Text(
                                  'العربية (AR)',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                            onChanged: (code) {
                              if (code != null) {
                                context.read<LanguageProvider>().setLanguage(
                                  code,
                                );
                              }
                            },
                          );
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
                          loc.intracore,
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

            Text(
              loc.welcomeBack,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // USERNAME
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: loc.username),
                      validator: (v) => v == null || v.isEmpty
                          ? '${loc.username} is required'
                          : null,
                    ),

                    SizedBox(height: h * 0.03),

                    // PASSWORD
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                        labelText: loc.password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() => _showPass = !_showPass);
                          },
                        ),
                      ),
                      validator: (v) => v == null || v.isEmpty
                          ? '${loc.password} is required'
                          : null,
                    ),

                    SizedBox(height: h * 0.03),

                    // REMEMBER ME
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
                            ),
                            Text(loc.rememberMe),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            loc.forgotPassword,
                            style: TextStyle(color: appBlue),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.04),

                    // LOGIN BUTTON
                    SizedBox(
                      height: h * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                        ),
                        child: Text(
                          loc.login,
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
