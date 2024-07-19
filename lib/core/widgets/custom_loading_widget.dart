import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_management/utility/constents.dart';


const spinKit =  SpinKitCircle(
  size: 50,
  color: kAccentColor,
  duration: Duration(milliseconds: 1200),
);
class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: spinKit);
  }
}
