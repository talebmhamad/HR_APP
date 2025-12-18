import 'package:flutter/material.dart';

// SHARED DECORATION
BoxDecoration cardDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.grey.shade200),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.02),
      blurRadius: 5,
      offset: const Offset(0, 2),
    ),
  ],
);

// SHARED HEADER
Widget buildCardHeader(String title) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    ),
    Divider(height: 1, color: Colors.grey.shade200),
  ],
);
