import 'package:flutter/material.dart';

enum MenuType { section, user, item }

class MenuItemModel {
  final MenuType type;

  // Common
  final String? title;

  // Item only
  final IconData? icon;
  final String? route;
  final bool showArrow;

  const MenuItemModel({
    required this.type,
    this.title,
    this.icon,
    this.route,
    this.showArrow = false,
  });
}
