import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/config/menu_config.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/widgets/page_appbar.dart';
import 'package:flutter_application_1/presentation/widgets/setting_item.dart';
import '../widgets/user_title.dart';
import 'package:flutter_application_1/data/models/menu_item_model.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

    final menuList = buildMenuList(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppPageAppBar(title: loc.menuMore, hasback: false),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          final item = menuList[index];

          switch (item.type) {
            case MenuType.section:
              return Padding(
                padding: EdgeInsets.only(
                  bottom: h * 0.005,
                  top: h * 0.02,
                  left: w * 0.05,
                  right: w * 0.05,
                ),
                child: Text(
                  item.title!,
                  style: const TextStyle(
                    color: Color.fromARGB(137, 5, 5, 5),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

            case MenuType.user:
              return UserTile(
                name: "Erpuim",
                initial: "E",
                color: appBlue,
                onTap: () {},
                radius: w * 0.07,
              );

            case MenuType.item:
              return SettingItem(
                icon: item.icon!,
                title: item.title!,
                showArrow: item.showArrow,
                onTap: item.route == null
                    ? null
                    : () => Navigator.pushNamed(context, item.route!),
              );
          }
        },
      ),
    );
  }
}
