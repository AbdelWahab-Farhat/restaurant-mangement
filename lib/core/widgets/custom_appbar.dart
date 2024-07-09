import 'package:flutter/material.dart';
import 'package:restaurant_management/utility/constents.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCentred;
  final bool? hasBackButton;
  final double? titleSize;

  const CustomAppbar({
    super.key,
    required this.title,
    required this.isCentred, this.hasBackButton, this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton != null?IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios ,color: Colors.white,)):null,
      title: Text(
        title,
        style:  TextStyle(
          fontSize: titleSize ?? 28,
          color: Colors.white, // Assuming white text on the app bar
        ),
      ),
      centerTitle: isCentred,
      backgroundColor: kDarkPrimaryColor, // Set a primary color for the app bar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
