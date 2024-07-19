import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/viewModel/all_reservations_cubit.dart';
import 'package:restaurant_management/features_admin/admin_home/presentation/views/home_admin_view.dart';
import 'package:restaurant_management/utility/helpers.dart';

import '../../../../../models/order/order.dart';
import '../../../../../models/order/orderItem.dart';
import 'order_item_card.dart';
import 'order_total_price_card.dart';

class ReservationOrderViewBody extends StatelessWidget {
  final Order order;
  const ReservationOrderViewBody({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OrderInfoCard(order: order),
            const SizedBox(height: 16.0),
            Text(
              'Order Items',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: order.orderItems.length,
                itemBuilder: (context, index) {
                  OrderItem orderItem = order.orderItems[index];
                  return OrderItemCard(orderItem: orderItem);
                },
              ),
            ),
            if (order.orderStatus != OrderStatus.completed)
            CustomOutLinedButton(onTap: ()  async {
             await context.read<AllReservationsCubit>().changeOrderState(order, OrderStatus.ongoing);
             snackBarShowing(context, 'Status Changed Successfully');
             pushReplacement(context, HomeAdminView());
            }, text: 'change Order State to ongoing'),

            const SizedBox(height: 10,),
            if (order.orderStatus != OrderStatus.completed)
              CustomOutLinedButton(onTap: () async {
              await context.read<AllReservationsCubit>().changeOrderState(order, OrderStatus.completed);
              snackBarShowing(context, 'Status Changed Successfully');
              pushReplacement(context, HomeAdminView());
            }, text: 'change Order State to Completed'),
            const SizedBox(height: 10,),
            OrderTotalPriceCard(totalPrice: order.totalPrice),
          ],
        ),
      ),
    );
  }
}



// class OrderInfoCard extends StatelessWidget {
//   final Order order;
//   const OrderInfoCard({super.key, required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Order ID: ${order.orderID}', style: const TextStyle(fontSize: 16.0)),
//             const SizedBox(height: 8.0),
//             Text('Customer ID: ${order.customerID}', style: const TextStyle(fontSize: 16.0)),
//             const SizedBox(height: 8.0),
//             Text('Order Status: ${order.orderStatus.toString().split('.').last}', style: const TextStyle(fontSize: 16.0)),
//             const SizedBox(height: 8.0),
//             Text('Order Date: ${order.orderDate}', style: const TextStyle(fontSize: 16.0)),
//           ],
//         ),
//       ),
//     );
//   }
// }


