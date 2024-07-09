
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_management/utility/constents.dart';

class  WidgetStyle {
  // static methods for Styleing.

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
}