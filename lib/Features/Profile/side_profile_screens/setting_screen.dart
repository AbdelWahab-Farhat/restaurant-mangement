
import 'package:flutter/material.dart';
import 'package:restaurant_management/Features/Auth/login/login_screen.dart';
import 'package:restaurant_management/Features/Profile/side_profile_screens/about_us_screen.dart';
import 'package:restaurant_management/Features/Profile/widgets/profile_menu_widget.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/models/user/customer.dart';
import 'package:restaurant_management/utility/helpers.dart';

import '../../../services/FirebaseServices/fireStore_service.dart';


class SettingScreen extends StatelessWidget {
  Customer customer;
   SettingScreen({super.key , required this.customer});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(title: 'Setting', isCentred: false,hasBackButton: true,),
      body: Column(
        children: [
          ProfileMenuWidget(title: 'Logout', icon: Icons.logout_outlined, onPress: () {
            showAlertDialog(context, 'Attempt to logout', 'Are you Sure you want to Logout ${customer.userName} ?', () {
              FirebaseService().logoutUser();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
            });
          },),
          ProfileMenuWidget(title: 'About Us', icon: Icons.logout_outlined, onPress:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen(),)),),
        ],
      ),
    );
  }
}
