import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/Features/home/menus/menu_item_detail_screen.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/size_config.dart';

import '../../../models/item.dart';

class MenuDetailScreen extends StatelessWidget {
  final List<Item> items;
  final String  menuName;
   const MenuDetailScreen({super.key, required this.items, required this.menuName,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: menuName, isCentred: true,hasBackButton: true,),
      body: Column(
        children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return menuDetailItem(context, items[index]);
                },),
            )
        ],
      ),
    );
  }

  Widget menuDetailItem(BuildContext context , Item item) {
    return  GestureDetector(

      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => MenuItemDetailScreen(item: item),)),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 3),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight / 3.9,
          decoration: const BoxDecoration(

          ),
          child: Stack(
            children: [
              CachedNetworkImage(imageUrl: item.itemImageURL,
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight / 3.9,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight / 7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xff000000),
                        const Color(0xff000000).withOpacity(0),
                      ],
                    ),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom:10,right: 20,left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.space/ 37,
                        ),
                        Text(
                          item.itemName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              '${item.price.toStringAsFixed(2)} LYD',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: kDarkSecondaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
