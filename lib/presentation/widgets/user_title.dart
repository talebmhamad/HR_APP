import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String initial;
  final Color color;
  final double radius;
  final VoidCallback? onTap;
  final String? imagePath; // ✅ NEW

  const UserTile({
    super.key,
    required this.name,
    required this.initial,
    required this.color,
    required this.radius,
    this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: radius * 0.4,
              horizontal: w * 0.05,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: radius,
                  backgroundColor: color,
                  backgroundImage: imagePath != null
                      ? AssetImage(imagePath!)
                      : null,
                  child: imagePath == null
                      ? Text(
                          initial,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: radius * 0.8,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                SizedBox(width: w * 0.04),
                Text(
                  name,
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
