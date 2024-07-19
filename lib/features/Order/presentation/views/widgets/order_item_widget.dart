import 'package:flutter/material.dart';
import 'package:restaurant_management/features/Order/presentation/views/widgets/right_info_column.dart';
import '../../../../../models/order/orderItem.dart';
import '../../../../../utility/size_config.dart';
import 'left_info_column.dart';
import 'order_image_box.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    required this.orderItem,
  });
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          OrderImageBox(orderItem: orderItem),
          SizedBox(width: SizeConfig.space),
          Expanded(
            child: LeftInfoColumn(orderItem: orderItem,),
          ),
          RightInfoColumn(orderItem: orderItem),
        ],
      ),
    );
  }
}



