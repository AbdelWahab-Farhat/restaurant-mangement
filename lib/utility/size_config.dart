

import 'package:flutter/cupertino.dart';

class SizeConfig{

  static late double screenWidth;
  static late double screenHeight;
  static late Orientation screenOrientation;
  static late double space;


  void initSizeConfig(BuildContext context){
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    screenOrientation = Orientation.portrait;
    space = screenWidth  * 0.026;
  }
}