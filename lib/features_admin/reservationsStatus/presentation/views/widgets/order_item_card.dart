import 'package:flutter/material.dart';

import '../../../../../models/order/orderItem.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItem orderItem;
  const OrderItemCard({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              orderItem.itemImageURL,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderItem.itemName, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Text(orderItem.des, style: TextStyle(fontSize: 14.0)),
                  SizedBox(height: 8.0),
                  Text('Quantity: ${orderItem.quantity}', style: TextStyle(fontSize: 14.0)),
                  SizedBox(height: 8.0),
                  Text('Price: \$${orderItem.price}', style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
