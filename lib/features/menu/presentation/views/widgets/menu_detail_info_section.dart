import 'package:flutter/material.dart';

import '../../../../../models/item.dart';
import '../../../../../utility/size_config.dart';

class MenuDetailInfoSection extends StatelessWidget {
  const MenuDetailInfoSection({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.space/ 37,
        ),
        Text(
          item.itemName,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        const SizedBox(width: 10),
        Text(
          '${item.price.toStringAsFixed(2)} LYD',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
