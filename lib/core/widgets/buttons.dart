import 'package:flutter/material.dart';

import '../../utility/constents.dart';
import '../../utility/size_config.dart';
import '../../utility/app_style.dart';


class CustomFilledButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double? width;
  final double? height;
  const CustomFilledButton({super.key, required this.onTap, required this.text, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Default width and height.
        width: width ?? SizeConfig.screenWidth,
        height: height ?? SizeConfig.screenHeight / 15,
        decoration: const BoxDecoration(
          color: kDarkPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),

        child: Center(child: Text(text,style: AppStyle.buttonTextStyle(),textAlign: TextAlign.center,)),
      ),
    );
  }
}
class CustomOutLinedButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double? width;
  final double? height;
  final TextStyle? style;
  const CustomOutLinedButton({super.key, required this.onTap, required this.text, this.width, this.height, this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Default width and height.
        width: width ?? SizeConfig.screenWidth,
        height: height ?? SizeConfig.screenHeight / 15,
        decoration:  BoxDecoration(
          border: Border.all(color: kDarkPrimaryColor),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),

        child: Center(child: Text(text,style: style ?? const TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),)),
      ),
    );
  }
}

class CustomFilledIconButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double? width;
  final double? height;
  final IconData? icon;
  const CustomFilledIconButton({super.key, required this.onTap, required this.text, this.width, this.height, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Default width and height.
        width: width ?? SizeConfig.screenWidth,
        height: height ?? SizeConfig.screenHeight / 15,
        decoration: const BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 40),
          child: Row(
            children: [
              Icon(icon,color: Colors.white,weight: 5,),
              const Spacer(),
              Center(child: Text(text,style: AppStyle.buttonTextStyle(),)),
            ],
          ),
        ),
      ),
    );
  }
}
