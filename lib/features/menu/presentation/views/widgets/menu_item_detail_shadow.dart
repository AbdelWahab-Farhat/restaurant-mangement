import 'package:flutter/material.dart';

import '../../../../../utility/size_config.dart';

class MenuItemDetailShadow extends StatelessWidget {
  const MenuItemDetailShadow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
