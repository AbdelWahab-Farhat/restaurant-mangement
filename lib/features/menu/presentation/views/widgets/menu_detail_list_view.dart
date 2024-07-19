import 'package:flutter/material.dart';

import '../../../../../models/item.dart';
import 'menu_detail_item_list_view.dart';
class MenuDetailListView extends StatelessWidget {
  const MenuDetailListView({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MenuDetailItemListView(item:items[index]);
      },);
  }
}
