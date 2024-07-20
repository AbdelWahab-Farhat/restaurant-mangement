
import 'package:flutter/material.dart';

import 'constents.dart';

class  AppStyle {
  static TextStyle buttonTextStyle(){
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17,
      color: Colors.white,
    );
  }
  static TextStyle bigTextStyle(){
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 30,
      color:kDarkPrimaryColor,
    );
  }
  static TextStyle textBodyBig = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 26,
    color:kDarkPrimaryColor,
  );
  static TextStyle textBodyMed = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: kDarkPrimaryColor
  );
  static TextStyle textBodySmall = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kDarkSecondaryColor
  );
}