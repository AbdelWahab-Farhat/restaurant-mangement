import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons.dart';
import '../../../../../models/order/orderItem.dart';
import '../../../../../utility/constents.dart';
import '../../../../../utility/size_config.dart';
import '../../viewModel/order_cubit.dart';
import 'show_addons.dart';

class LeftInfoColumn extends StatelessWidget {
  final OrderItem orderItem;

  const LeftInfoColumn({
    super.key,
    required this.orderItem,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orderItem.itemName,
          style: const TextStyle(
            color: kDarkPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SizeConfig.space * 0.5),
        if (orderItem.addons != null && orderItem.addons!.isNotEmpty)
          ShowAddons(itemAddons: orderItem.addons!),
        SizedBox(height: SizeConfig.space * 0.5),
        BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return CustomOutLinedButton(
              width: SizeConfig.space * 8,
              height: SizeConfig.space * 3,
              style: const TextStyle(
                color: kDarkSecondaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
              onTap: () => context.read<OrderCubit>().removeOrderItem(context.read<OrderCubit>().cubitOrderItems, orderItem),
              text: 'Remove',
            );
          },
        ),
      ],
    );
  }
}
