import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/widgets/page_appbar.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/routes/route_names.dart';

class AccountControlPage extends StatelessWidget {
  const AccountControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppPageAppBar(title: loc.accountControl),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // INFO TEXT
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.018,
            ),
            color: Colors.grey.shade100,
            child: Text(
              loc.accountDeleteWarning,
              style: TextStyle(color: Colors.black87, fontSize: w * 0.038),
            ),
          ),

          // DELETE ACCOUNT
          Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04),
                leading: auth.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: w * 0.065,
                      ),
                title: Text(
                  loc.deleteAccount,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: auth.isLoading
                    ? null
                    : () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(loc.deleteAccount),
                            content: Text(loc.accountDeleteConfirm),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(loc.cancel),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(
                                  loc.deleteAccount,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirmed != true) return;

                        final success = await auth.deleteAccount();

                        if (!context.mounted) return;

                        if (success) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.login,
                            (_) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loc.operationFailed)),
                          );
                        }
                      },
              );
            },
          ),

          Divider(
            height: h * 0.0015,
            thickness: h * 0.0015,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
