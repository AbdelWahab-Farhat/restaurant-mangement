import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/item.dart';
import '../../../../../utility/constents.dart';
import '../../../../../utility/functions/price_functions.dart';
import '../../../../../utility/size_config.dart';
import '../../viewModel/price_cubit/price_cubit.dart';
import 'add_item_button.dart';

class AddToCartBox extends StatelessWidget {
  const AddToCartBox({
    super.key,
    required this.item,
    required this.quantity,
  });

  final Item item;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight / 38, right: 20),
      width: SizeConfig.screenWidth / 1.4,
      height: 120,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(38),
            topLeft: Radius.circular(38),
            bottomRight: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
            )
          ]),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2, bottom: 5),
            child: Text('Total Price'),
          ),
          BlocBuilder<PriceCubit, PriceState>(
            builder: (context, state) {
              return SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Center(
                      child: Text(
                    'LY ${countItemFullPrice(item, quantity, context.read<PriceCubit>().addons).toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: kDarkPrimaryColor,
                        fontSize: 27,
                        fontWeight: FontWeight.w700),
                  )));
            },
          ),
         AddItemButton(item: item, quantity: quantity)
        ],
      ),
    );
  }
}

