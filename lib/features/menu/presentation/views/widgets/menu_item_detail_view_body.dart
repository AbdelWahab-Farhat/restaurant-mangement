
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/widgets/buttons.dart';
import '../../../../../core/widgets/custom_back_arrow.dart';
import '../../../../../core/widgets/custom_cached_Image.dart';
import '../../../../../models/item.dart';
import '../../../../../utility/constents.dart';
import '../../../../../utility/size_config.dart';
import 'add_to_cart_box.dart';
import 'menu_item_Detail_pick_addons.dart';
import 'menu_item_detail_info_section.dart';
import 'menu_item_detail_shadow.dart';

class MenuItemDetailViewBody extends StatefulWidget {
  final Item item;
  const MenuItemDetailViewBody({super.key, required this.item});

  @override
  State<MenuItemDetailViewBody> createState() => _MenuItemDetailViewBodyState();
}

class _MenuItemDetailViewBodyState extends State<MenuItemDetailViewBody> {
  int quantity = 1;
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
            const MenuItemDetailShadow(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
                width: SizeConfig.screenWidth,
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
                      MenuItemDetailInfoSection(item: widget.item),
                      SizedBox(
                        height: SizeConfig.space * 2,
                      ),
                      const Divider(
                        color: kDarkSecondaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MenuItemDetailPickAddons(item: widget.item),
                      SizedBox(
                        height: SizeConfig.space * 2,
                      ),
                      quantityShow(),
                      SizedBox(
                        height: SizeConfig.space * 4,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        child: Stack(
                          children: [
                            const PriceBoxDesign(),
                            Align(
                              alignment: Alignment.topRight,
                              child: AddToCartBox(
                                  item: widget.item, quantity: quantity),
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
              child: const Padding(
                padding: EdgeInsets.only(right: 20, left: 10),
                child: CustomBackArrow(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Row quantityShow() {
    return Row(
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
    );
  }
}
class PriceBoxDesign extends StatelessWidget {
  const PriceBoxDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth / 4,
      height: SizeConfig.screenHeight / 5,
      decoration: const BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(38),
              bottomRight: Radius.circular(38),
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30))),
    );
  }
}