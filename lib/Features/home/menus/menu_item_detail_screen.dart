import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:restaurant_management/Features/root/root_client.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/core/widgets/custom_cached_Image.dart';
import 'package:restaurant_management/models/order/orderItem.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:uuid/uuid.dart';
import '../../../Blocs/order_bloc/order_bloc.dart';
import '../../../models/addon.dart';
import '../../../models/item.dart';
import '../../../utility/size_config.dart';

class MenuItemDetailScreen extends StatefulWidget {
  final Item item;

  const MenuItemDetailScreen({super.key, required this.item});

  @override
  State<MenuItemDetailScreen> createState() => _MenuItemDetailScreenState();
}

class _MenuItemDetailScreenState extends State<MenuItemDetailScreen> {
  int quantity = 1;
  List<Addon> selectedAddons = [];
  void _showMultiSelect(BuildContext context, List<Addon>? addons) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          itemsTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: kDarkPrimaryColor),
          selectedColor: kAccentColor,
          backgroundColor: kLightPrimaryColor,
          confirmText: const Text(
            'Confirm',
            style: TextStyle(color: kDarkSecondaryColor, fontSize: 19),
          ),
          cancelText: const Text(
            'Cancel',
            style: TextStyle(color: kDarkSecondaryColor, fontSize: 19),
          ),
          title: Text('Addon On ${widget.item.itemName}'),
          height: 200,
          items: widget.item.addons!
              .map((addon) => MultiSelectItem<Addon>(
                    addon,
                    "${addon.addonName}\t\t\t\t${addon.addonPrice} LY",
                  ))
              .toList(),
          initialValue: selectedAddons,
          onConfirm: (values) {
            setState(() {
              selectedAddons = values.cast<Addon>();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: SizeConfig.screenHeight / 3,
                width: SizeConfig.screenWidth,
                child: CustomCachedImage(
                  imageUrl: widget.item.itemImageURL,
                )),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight / 7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xff000000).withOpacity(0),
                    const Color(0xff000000).withOpacity(0.5),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.screenHeight / 1.35,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(42),
                        topLeft: Radius.circular(42))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.itemName,
                        style: const TextStyle(
                            color: kDarkPrimaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            'LY. ${widget.item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: kDarkPrimaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('  / Per item.'),
                        ],
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                            color: kDarkPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.item.des,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(
                        height: SizeConfig.space * 2,
                      ),
                      const Divider(
                        color: kDarkSecondaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (widget.item.addons != null)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Customize your Order',
                            style: TextStyle(
                                color: kDarkPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      if (widget.item.addons != null)
                        GestureDetector(
                          onTap: () =>
                              _showMultiSelect(context, widget.item.addons),
                          child: Container(
                            width: SizeConfig.screenWidth,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.25),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  '- Select Your Favorite Addon',
                                  style: TextStyle(color: kDarkSecondaryColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: kDarkPrimaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: SizeConfig.space * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Item Quantity',
                            style: TextStyle(
                                color: kDarkSecondaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          const Spacer(),
                          SizedBox(
                              height: 38,
                              width: 50,
                              child: CustomFilledButton(
                                text: '+',
                                onTap: () {
                                  if (quantity > 99) {
                                    return;
                                  } else {
                                    setState(() {
                                      quantity++;
                                    });
                                  }
                                },
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                              height: 38,
                              width: 50,
                              child: CustomOutLinedButton(
                                onTap: () {},
                                text: quantity.toString(),
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                              height: 38,
                              width: 50,
                              child: CustomFilledButton(
                                text: '-',
                                onTap: () {
                                  if (quantity <= 1) {
                                    return;
                                  } else {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                              )),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.space * 4,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        child: Stack(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth / 4,
                              height: SizeConfig.screenHeight / 5,
                              decoration: const BoxDecoration(
                                  color: kAccentColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(38),
                                      bottomRight: Radius.circular(38),
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.screenHeight / 38,
                                    right: 20),
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
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Text('Total Price'),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    SizedBox(
                                        width: SizeConfig.screenWidth,
                                        child: Center(
                                            child: Text(
                                          'LY ${(quantity * widget.item.price).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: kDarkPrimaryColor,
                                              fontSize: 27,
                                              fontWeight: FontWeight.w700),
                                        ))),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    CustomFilledIconButton(
                                      onTap: () {
                                        final orderItem = OrderItem(
                                            orderItemId: const Uuid().v1(),
                                            itemID: widget.item.itemID,
                                            itemName: widget.item.itemName,
                                            itemImageURL:
                                                widget.item.itemImageURL,
                                            price: widget.item.price,
                                            des: widget.item.des,
                                            quantity: quantity,
                                            addons: selectedAddons,
                                            userID: FirebaseService()
                                                .frAuth
                                                .currentUser!
                                                .uid);
                                        context.read<OrderBloc>().add(
                                            AddOrderItemEvent(
                                                orderItem: orderItem));
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Root(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      text: 'Add to Cart',
                                      icon: Icons.shopping_cart_outlined,
                                      height: SizeConfig.screenHeight / 20,
                                      width: SizeConfig.screenWidth / 2,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 20,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
