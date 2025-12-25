import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;

  final Widget? destination; // Optional navigation
  final VoidCallback? onTap; // Optional custom action

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    this.destination,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!(); //  Custom tap action
            } else if (destination != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => destination!), //  Navigate
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: h * 0.025,
              horizontal: w * 0.04,
            ),
            child: Row(
              children: [
                Icon(icon, size: w * 0.08, color: Colors.black54),
                SizedBox(width: w * 0.04),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: w * 0.04,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
      ],
    );
  }
}
