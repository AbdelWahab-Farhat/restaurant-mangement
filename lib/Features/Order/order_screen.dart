import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/Features/payment/payment_screen.dart';
import 'package:restaurant_management/Features/home/menus/menu_item_detail_screen.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/core/widgets/custom_cached_Image.dart';
import 'package:restaurant_management/models/order/orderItem.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/helpers.dart';
import '../../Blocs/order_bloc/order_bloc.dart';
import '../../models/addon.dart';
import '../../utility/size_config.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    context.read<OrderBloc>().add(LoadOrderItemsEvent());
    super.initState();
  }

  Widget showAddons(List<Addon> addons) {
    int ranked = 1;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: addons.map((e) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "${ranked++}- ${e.addonName}",
              style: TextStyle(color: kDarkSecondaryColor.withOpacity(0.8)),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Order Items', isCentred: true),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderSuccess) {
            return Column(
              children: [
                Expanded(
                  child: _buildOrderItems(context, state.orderItems),
                ),
                if (state.orderItems.isNotEmpty) _buildPaymentButton(context,state.orderItems),
              ],
            );
          }
          else if (state is OrderInitial) {
            return Column(
              children: [
                Expanded(
                  child: _buildOrderItems(context, state.orderItems),
                ),
                if (state.orderItems.isNotEmpty) _buildPaymentButton(context,state.orderItems),
              ],
            );
          }
          else if (state is OrderError) {
            return const Center(
              child: Text('Error Fetching Cart, Check Internet.'),
            );
          } else if (state is OrderLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kAccentColor,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildOrderItems(BuildContext context, List<OrderItem> orderItems) {
    if (orderItems.isEmpty) {
      return const Center(
        child: Text(
          'No Items In Cart',
          style: TextStyle(color: kDarkSecondaryColor, fontSize: 18),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.space * 10, top: SizeConfig.space),
      child: ListView.builder(
        itemCount: orderItems.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          OrderItem orderItem = orderItems[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuItemDetailScreen(item: orderItem),
                      ),
                    ),
                    child: CustomCachedImage(
                      imageUrl: orderItem.itemImageURL,
                      width: SizeConfig.space * 7.5,
                      height: SizeConfig.space * 7.5,
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.space),
                Expanded(
                  child: Column(
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
                        showAddons(orderItem.addons!),
                      SizedBox(height: SizeConfig.space * 0.5),
                      CustomOutLinedButton(
                        width: SizeConfig.space * 8,
                        height: SizeConfig.space * 3,
                        style: const TextStyle(
                          color: kDarkSecondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                        onTap: () {
                          context.read<OrderBloc>().add(RemoveOrderItemEvent(orderItem: orderItem));
                        },
                        text: 'Remove',
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Quantity: ${orderItem.quantity}",
                      style: TextStyle(
                        color: kDarkSecondaryColor.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: SizeConfig.space * 6,
                      child: const Divider(),
                    ),
                    Text(
                      "Total: ${orderItem.totalItemPrice.toStringAsFixed(2)} LY",
                      style: const TextStyle(
                        color: kDarkSecondaryColor,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context , List<OrderItem> items) {
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
        text: 'Proceed to Payment\n${totalItemsPrice(items).toStringAsFixed(2)} LY',
        width: SizeConfig.screenWidth,
      ),
    );
  }
}
