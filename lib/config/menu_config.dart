import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/menu_item_model.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/routes/route_names.dart';

List<MenuItemModel> buildMenuList(BuildContext context) {
  final loc = AppLocalizations.of(context)!;

  return [
    MenuItemModel(type: MenuType.section, title: loc.menuOrganization),
    const MenuItemModel(type: MenuType.user),

    MenuItemModel(type: MenuType.section, title: loc.menuOverview),
    MenuItemModel(
      type: MenuType.item,
      icon: Icons.work_outline,
      title: loc.menuTimeOff,
      showArrow: false,
    ),

    MenuItemModel(type: MenuType.section, title: loc.menuAccount),
    MenuItemModel(
      type: MenuType.item,
      icon: Icons.person_outline,
      title: loc.menuPersonalSettings,
      route: RouteNames.settings,
      showArrow: true,
    ),

    MenuItemModel(type: MenuType.section, title: loc.menuHelp),
    MenuItemModel(
      type: MenuType.item,
      icon: Icons.help_outline,
      title: loc.menuSupport,
      showArrow: false,
    ),
  ];
}
