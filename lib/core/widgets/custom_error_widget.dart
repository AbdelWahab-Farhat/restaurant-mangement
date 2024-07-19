import 'package:flutter/material.dart';
import 'package:restaurant_management/utility/app_style.dart';


class CustomErrorWidget extends StatelessWidget {
  final String errMessage;
  const CustomErrorWidget({super.key, required this.errMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errMessage,style:AppStyle.textBodyMed,),
    );
  }
}
