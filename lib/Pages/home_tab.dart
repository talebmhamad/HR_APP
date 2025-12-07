import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          // 🔹 TOP BAR
          Container(
            padding: EdgeInsets.only(
              top: h * 0.04, // 3% of screen height
              bottom: h * 0.015, // 1.5% of screen height
              left: w * 0.04, // 4% of screen width
              right: w * 0.04,
            ),
            // 🔹 Add this decoration section
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: w * 0.10), // Responsive empty space

                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: w * 0.05, // 5% of screen width
                    fontWeight: FontWeight.w600,
                  ),
                ),

                CircleAvatar(
                  radius: 22,
                  backgroundColor: appBlue,
                  child: Text("T", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // Thin Divider Like Screenshot
          Divider(height: 1, thickness: 1),

          // 🔹 Main Content Below
          Expanded(
            child: Center(
              child: Text(
                "Welcome to Dashboard",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
