import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
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
    );
  }
}
