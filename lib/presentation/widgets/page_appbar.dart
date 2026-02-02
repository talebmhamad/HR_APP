import 'package:flutter/material.dart';

class AppPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool hasback;

  const AppPageAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.hasback = true,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return AppBar(
      leading: hasback
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
