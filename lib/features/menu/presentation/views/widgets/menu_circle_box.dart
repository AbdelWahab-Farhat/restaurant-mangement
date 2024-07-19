import 'package:flutter/material.dart';

import '../../../../../models/menu/menu.dart';
import '../../../../../utility/size_config.dart';
import 'menu_info.dart';


class MenuCircleBox extends StatelessWidget {
  const MenuCircleBox({
    super.key,
    required this.menu,
  });


  final Menu menu;

  @override
  Widget build(BuildContext context) {
    double radiusLeftSide = 30;
    double radiusRightSide = 15;
    return Center(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusLeftSide),
          bottomLeft: Radius.circular(radiusLeftSide),
          topRight: Radius.circular(radiusRightSide),
          bottomRight: Radius.circular(radiusRightSide),
        ),
        child: SizedBox(
          width: SizeConfig.screenWidth / 1.2,
          height: SizeConfig.screenHeight / 9,
          child: Row(
            children: [
              SizedBox(width: SizeConfig.screenWidth / 5),
              MenuInfo(menu: menu),
            ],
          ),
        ),
      ),
    );
  }
}
