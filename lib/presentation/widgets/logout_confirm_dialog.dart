import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(loc.logout),
      content: Text(loc.logoutConfirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(loc.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(loc.logout, style: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
