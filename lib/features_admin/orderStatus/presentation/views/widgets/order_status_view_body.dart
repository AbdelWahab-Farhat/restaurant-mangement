import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/order/order.dart';
import '../../viewModel/order_status_cubit/order_status_cubit.dart';
import 'custom_tab_bar_view_body.dart';

class OrderStatusViewBody extends StatefulWidget {
  const OrderStatusViewBody({super.key});

  @override
  State<OrderStatusViewBody> createState() => _OrderStatusViewBodyState();
}

class _OrderStatusViewBodyState extends State<OrderStatusViewBody> {
  @override
  void initState() {
    context.read<OrderStatusCubit>().fetchCustomersForEachOrder();
    context.read<OrderStatusCubit>().fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders Status'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending', icon: Icon(Icons.pending)),
              Tab(text: 'In Progress', icon: Icon(Icons.work)),
              Tab(text: 'Completed', icon: Icon(Icons.check_circle)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CustomTabBarViewBody(orderStatus: OrderStatus.pending,),
            CustomTabBarViewBody(orderStatus: OrderStatus.ongoing,),
            CustomTabBarViewBody(orderStatus: OrderStatus.completed,),
          ],
        ),
      ),
    );
  }
}

