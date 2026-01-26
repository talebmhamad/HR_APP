import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/employee_model.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/widgets/page_appbar.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  final EmployeeModel employee;

  const EditProfilePage({super.key, required this.employee});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController(text: widget.employee.firstName);
    _lastNameCtrl = TextEditingController(text: widget.employee.lastName);
    _emailCtrl = TextEditingController(text: widget.employee.email);
    _phoneCtrl = TextEditingController(text: widget.employee.phoneNumber);
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppPageAppBar(title: 'Edit Profile'),
      body: Consumer<EmployeeProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildField(label: 'First Name', controller: _firstNameCtrl),
                  _buildField(label: 'Last Name', controller: _lastNameCtrl),
                  _buildField(
                    label: loc.email,
                    controller: _emailCtrl,
                    readOnly: true,
                  ),
                  _buildField(
                    label: loc.phoneNumber,
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              if (!_formKey.currentState!.validate()) return;

                              await provider.updateProfile(
                                firstName: _firstNameCtrl.text.trim(),
                                lastName: _lastNameCtrl.text.trim(),
                                phoneNumber: _phoneCtrl.text.trim(),
                              );

                              if (!mounted) return;

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Profile updated successfully'),
                                ),
                              );
                            },
                      child: provider.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
          if (keyboardType == TextInputType.phone && value.length < 8) {
            return 'Invalid phone number';
          }
          return null;
        },
      ),
    );
  }
}
