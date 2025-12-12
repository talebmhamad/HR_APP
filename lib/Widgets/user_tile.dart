import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String initial;
  final Color color;
  final Widget destination;
  final double radius; // You can manually control it

  const UserTile({
    super.key,
    required this.name,
    required this.initial,
    required this.color,
    required this.destination,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => destination),
            );
          },
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
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: radius * 0.8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
