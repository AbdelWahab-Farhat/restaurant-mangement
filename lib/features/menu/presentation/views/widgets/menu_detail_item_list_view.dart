import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../models/item.dart';
import '../../../../../utility/size_config.dart';
import '../menu_item_detail_view.dart';
import 'menu_detail_info_section.dart';

class MenuDetailItemListView extends StatelessWidget {
  final Item item;
  const MenuDetailItemListView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => MenuItemDetailView(item: item),)),
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
                    child: MenuDetailInfoSection(item: item),
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

