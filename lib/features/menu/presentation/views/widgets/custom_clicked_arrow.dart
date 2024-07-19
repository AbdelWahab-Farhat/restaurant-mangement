import 'package:flutter/material.dart';

import '../../../../../utility/size_config.dart';


class CustomClickedArrow extends StatelessWidget {
  const CustomClickedArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: 5,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(5),
        width: SizeConfig.space * 3,
        height: SizeConfig.space * 3,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            size: SizeConfig.space * 2,
          ),
        ),
      ),
    );
  }
}
