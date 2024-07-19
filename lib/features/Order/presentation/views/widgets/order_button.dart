import 'package:flutter/material.dart';

import '../../../../../core/widgets/buttons.dart';
import '../../../../../models/order/orderItem.dart';
import '../../../../../utility/functions/price_functions.dart';
import '../../../../../utility/size_config.dart';
import '../../../../payment/presentation/views/payment_screen.dart';

class OrderButton extends StatelessWidget {
  final List<OrderItem> orderItems;
  const OrderButton({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, right: 30, left: 30),
      child: CustomFilledButton(
        height: SizeConfig.space * 7,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentScreen()),
          );
        },
        text: 'Proceed to Payment\n${totalItemsPrice(orderItems).toStringAsFixed(2)} LY',
        width: SizeConfig.screenWidth,
      ),
    );
  }
}