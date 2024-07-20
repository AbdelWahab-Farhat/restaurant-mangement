
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../../core/widgets/custom_appbar.dart';
import '../../../models/user/customer.dart';
import '../../../services/FirebaseServices/fireStore_service.dart';
import '../../../utility/helpers.dart';
import '../../auth/presentation/views/login_view.dart';
import '../widgets/profile_menu_widget.dart';
import 'about_us_screen.dart';


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
            showAlertDialog(context, 'Attempt to logout', 'Are you Sure you want to Logout ${customer.userName} ?', ()  {
               FirebaseAuth.instance.signOut().whenComplete(() => pushAndRemoveUntil(context, const LoginView(),false),);
            },null);
          },),
          ProfileMenuWidget(title: 'About Us', icon: Icons.logout_outlined, onPress:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsScreen(),)),),
        ],
      ),
    );
  }
}
