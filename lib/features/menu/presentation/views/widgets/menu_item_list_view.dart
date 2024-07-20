import 'package:flutter/material.dart';

import '../../../../../models/menu/menu.dart';
import '../../../../../utility/helpers.dart';
import '../../../../../utility/size_config.dart';
import '../menu_detail_view.dart';
import 'custom_clicked_arrow.dart';
import 'image_list_view_item_box.dart';
import 'menu_circle_box.dart';


class MenuItemListView extends StatelessWidget {
  final Menu menu;
  const MenuItemListView({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => goToMenuDetailView(context),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Stack(
              children: [
                MenuCircleBox(menu: menu),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ImageListViewItemBox(menu: menu)
                ),
                const Align(
                  alignment: Alignment(0.9, 0),
                  heightFactor: 2.8,
                  child: CustomClickedArrow(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void goToMenuDetailView(BuildContext context) => push(context, MenuDetailView(items: menu.menuItems!, menuName: menu.menuName));
}


