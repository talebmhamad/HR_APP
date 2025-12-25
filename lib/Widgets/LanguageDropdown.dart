import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/language_provider.dart';

class LanguageDropdown extends StatelessWidget {
  final GlobalKey<PopupMenuButtonState<String>> menuKey;
  final Color dropdownColor;

  const LanguageDropdown({
    super.key,
    required this.menuKey,
    this.dropdownColor = const Color(0xFF2196F3),
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final currentCode = provider.locale.languageCode;

    return PopupMenuButton<String>(
      key: menuKey, // Attach the key here
      initialValue: currentCode,
      color: dropdownColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (String code) {
        provider.setLanguage(code);
      },
      itemBuilder: (BuildContext context) => [
        _buildMenuItem('en', 'English (US)', currentCode),
        _buildMenuItem('ar', 'العربية (AR)', currentCode),
      ],
      // We hide the default icon by using a SizedBox since the row is the trigger
      child: const Icon(Icons.arrow_forward_ios, size: 17, color: Colors.grey),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    String code,
    String label,
    String current,
  ) {
    bool isSelected = code == current;
    return PopupMenuItem<String>(
      value: code,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isSelected)
            const Icon(Icons.check, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}
