import 'package:flutter/material.dart';

import '../../../../models/item.dart';
import 'widgets/menu_detail_body.dart';


class MenuDetailView extends StatelessWidget {
  final List<Item> items;
  final String  menuName;
   const MenuDetailView({super.key, required this.items, required this.menuName,});

  @override
  Widget build(BuildContext context) {
    return MenuDetailBody(items: items, menuName: menuName,);
  }


}

