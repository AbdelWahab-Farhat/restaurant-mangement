import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../models/order/order.dart';
import '../../../../../utility/app_style.dart';
import '../../viewModel/order_status_cubit/order_status_cubit.dart';

class CustomTabBarViewBody extends StatelessWidget {
  final OrderStatus orderStatus;

  const CustomTabBarViewBody({
    super.key,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<OrderStatusCubit, OrderStatusState>(
        builder: (context, state) {
          if (state is OrderStatusFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else if (state is OrderStatusSuccess) {
            List<Order> orders = context
                .read<OrderStatusCubit>()
                .getOrdersByStatus(state.orders, orderStatus);
            if (orders.isEmpty) {
              return Center(
                child: Text(
                  'No Orders',
                  style: AppStyle.textBodyMed,
                ),
              );
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return OrderListItem(order: orders[index]);
              },
            );
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final Order order;

  const OrderListItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.read<OrderStatusCubit>().getCustomerByOrder(order)?.userName ?? 'someone',
                    style: AppStyle.textBodyMed.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Order ID: ${order.orderID}', style: AppStyle.textBodyMed),
                  const SizedBox(height: 8.0),
                  Text('Order Date: ${order.orderDate}', style: AppStyle.textBodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Total Price:',
                  style: AppStyle.textBodyMed.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$${order.totalPrice.toStringAsFixed(2)}',
                  style: AppStyle.textBodyMed.copyWith(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
