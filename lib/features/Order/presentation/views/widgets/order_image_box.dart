import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_cached_Image.dart';
import '../../../../../models/order/orderItem.dart';
import '../../../../../utility/size_config.dart';

class OrderImageBox extends StatelessWidget {
  const OrderImageBox({
    super.key,
    required this.orderItem,
  });

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomCachedImage(
        imageUrl: orderItem.itemImageURL,
        width: SizeConfig.space * 7.5,
        height: SizeConfig.space * 7.5,
      ),
    );
  }
}
