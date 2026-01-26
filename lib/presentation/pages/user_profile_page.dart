import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/pages/edit_profile_age.dart';
import 'package:flutter_application_1/presentation/widgets/page_appbar.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final employee = context.watch<EmployeeProvider>().employee;

    if (employee == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppPageAppBar(
        title: loc.profile,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(employee: employee),
                ),
              );
            },
          ),
        ],
      ),

      body: ListView(
        children: [
          _section(
            context,
            title: loc.personalInfo,
            children: [
              _item(loc.fullName, '${employee.firstName} ${employee.lastName}'),
              _item(loc.memberCode, employee.employeeId.toString()),
              _item(
                loc.position,
                employee.department.isNotEmpty ? employee.department : '-',
              ),
              _item(loc.role, loc.member),
            ],
          ),
          _section(
            context,
            title: loc.loginSecurity,
            children: [
              _item(loc.email, employee.email),
              _item(loc.phoneNumber, employee.phoneNumber ?? '-'),
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
    return ListTile(title: Text(title), subtitle: Text(value), onTap: () {});
  }
}
