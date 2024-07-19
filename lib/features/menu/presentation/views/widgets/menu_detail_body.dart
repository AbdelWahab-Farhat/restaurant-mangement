import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../models/item.dart';
import 'menu_detail_list_view.dart';

class MenuDetailBody extends StatelessWidget {
  final List<Item> items;
  final String  menuName;
  const MenuDetailBody({super.key, required this.items, required this.menuName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: menuName, isCentred: true,hasBackButton: true,),
    body: MenuDetailListView(items: items)
    );
  }
}
