import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_cached_Image.dart';
import '../../../../../models/menu/menu.dart';
import '../../../../../utility/size_config.dart';

class ImageListViewItemBox extends StatelessWidget {
  final Menu menu;
  const ImageListViewItemBox({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 4, left: 10),
      clipBehavior: Clip.hardEdge,
      height: SizeConfig.space * 8,
      width: SizeConfig.space * 8,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      // Placeholder Image Later
      child: CustomCachedImage(
        imageUrl: menu.menuItems!.last.itemImageURL,
      ),
    );
  }
}
