import 'package:flutter/material.dart';
import '../../../../../models/order/orderItem.dart';
import '../../../../../utility/constents.dart';
import 'order_item_widget.dart';

class ListViewOrderItems extends StatelessWidget {
  final List<OrderItem> orderItems;
  const ListViewOrderItems({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    if (orderItems.isEmpty) {
      return const Center(
        child: Text(
          'No Items In Cart',
          style: TextStyle(color: kDarkSecondaryColor, fontSize: 18),
        ),
      );
    }
    return ListView.builder(
      itemCount: orderItems.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        OrderItem orderItem = orderItems[index];
        return OrderItemWidget(orderItem: orderItem);
      },
    );
  }
}

