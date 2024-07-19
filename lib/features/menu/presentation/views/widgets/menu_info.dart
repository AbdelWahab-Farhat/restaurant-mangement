import 'package:flutter/material.dart';

import '../../../../../models/menu/menu.dart';

class MenuInfo extends StatelessWidget {
  const MenuInfo({
    super.key,
    required this.menu,
  });

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menu.menuName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Items: ${menu.numberOfItems}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
