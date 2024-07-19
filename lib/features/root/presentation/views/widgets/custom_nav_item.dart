import 'package:flutter/material.dart';

import '../../../../../utility/constents.dart';

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const CustomNavItem({
    super.key, required this.icon, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(height: 5,),
           Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: kDarkSecondaryColor)),
        ],
      ),
    );
  }
}