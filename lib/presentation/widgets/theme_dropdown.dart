import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class ThemeDropdown extends StatelessWidget {
  final GlobalKey<PopupMenuButtonState<String>> menuKey;

  const ThemeDropdown({super.key, required this.menuKey});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return PopupMenuButton<String>(
      key: menuKey,
      icon: const Icon(Icons.arrow_drop_down),
      onSelected: (value) {
        if (value == 'light') {
          themeProvider.setTheme(false);
        } else {
          themeProvider.setTheme(true);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'light',
          child: Row(
            children: const [
              Icon(Icons.light_mode, size: 18),
              SizedBox(width: 8),
              Text('Light'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'dark',
          child: Row(
            children: const [
              Icon(Icons.dark_mode, size: 18),
              SizedBox(width: 8),
              Text('Dark'),
            ],
          ),
        ),
      ],
    );
  }
}
