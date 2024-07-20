import 'package:flutter/material.dart';

import '../../../../../models/order/orderItem.dart';
import '../../../../../utility/constents.dart';
import '../../../../../utility/functions/price_functions.dart';
import '../../../../../utility/size_config.dart';

class RightInfoColumn extends StatelessWidget {
  const RightInfoColumn({
    super.key,
    required this.orderItem,
  });

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Quantity: ${orderItem.quantity}",
          style: TextStyle(
            color: kDarkSecondaryColor.withOpacity(0.5),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: SizeConfig.space * 6,
          child: const Divider(),
        ),
        Text(
          "Total: ${countItemFullPrice(orderItem, orderItem.quantity, orderItem.addons!).toStringAsFixed(2)} LY",
          style: const TextStyle(
            color: kDarkSecondaryColor,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
