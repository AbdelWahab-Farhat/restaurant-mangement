import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/core/widgets/custom_error_widget.dart';
import 'package:restaurant_management/core/widgets/custom_loading_widget.dart';
import 'package:restaurant_management/features/Order/presentation/viewModel/order_cubit.dart';
import 'package:restaurant_management/features/Order/presentation/views/widgets/list_view_order_items.dart';
import 'package:restaurant_management/features/Order/presentation/views/widgets/order_button.dart';
import '../../../../../core/widgets/custom_appbar.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  @override
  void initState() {
    context.read<OrderCubit>().fetchUserOrderItems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Order Items', isCentred: true),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListViewOrderItems(orderItems: state.orderItems),
                ),
                if (state.orderItems.isNotEmpty) OrderButton(orderItems: state.orderItems),
              ],
            );
          }
          else if (state is OrderFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else  {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
