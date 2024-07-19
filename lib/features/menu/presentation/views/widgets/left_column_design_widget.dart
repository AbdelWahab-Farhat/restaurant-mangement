import 'package:flutter/material.dart';

import '../../../../../utility/constents.dart';
import '../../../../../utility/size_config.dart';


class LeftColumnDesignWidget extends StatelessWidget {
  const LeftColumnDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double radiusRight = 38;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: SizeConfig.space * 9.7,
        height: SizeConfig.space * 52,
        decoration: BoxDecoration(
            color: kDarkPrimaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(radiusRight),
                bottomRight: Radius.circular(radiusRight))),
      ),
    );
  }
}
