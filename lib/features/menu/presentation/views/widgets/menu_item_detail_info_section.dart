import 'package:flutter/material.dart';

import '../../../../../models/item.dart';
import '../../../../../utility/constents.dart';

class MenuItemDetailInfoSection extends StatelessWidget {
  final Item item;
  const MenuItemDetailInfoSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.itemName,
          style: const TextStyle(
              color: kDarkPrimaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Spacer(),
            Text(
              'LY. ${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: kDarkPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('  / Per item.'),
          ],
        ),
        const Text(
          'Description',
          style: TextStyle(
              color: kDarkPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        Text(
          item.des,
          style:
          const TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }
}
