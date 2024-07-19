import 'package:flutter/material.dart';

class OrderTotalPriceCard extends StatelessWidget {
  final double totalPrice;
  const OrderTotalPriceCard({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total Price:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            Text('\$${totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
