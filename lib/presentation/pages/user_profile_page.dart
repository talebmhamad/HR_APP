import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/widgets/page_appbar.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    // Initialize provider to update the subtitle dynamically

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppPageAppBar(title: loc.profile),
      body: ListView(
        children: [
          _section(
            context,
            title: loc.personalInfo,
            children: [
              _item(loc.fullName, "Test"),
              _item(loc.memberCode, "Tes-1"),
              _item(loc.position, "-"),
              _item(loc.role, loc.member),
            ],
          ),
          _section(
            context,
            title: loc.loginSecurity,
            children: [
              _item(loc.email, "mhamad@gmail.com"),
              _item(loc.phoneNumber, "96170381880"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _item(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: () {},
    );
  }
}
