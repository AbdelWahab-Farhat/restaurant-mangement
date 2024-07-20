import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Order/order_view.dart';
import '../../../Profile/profile_screen.dart';
import '../../../Reservation/presentation/views/reservation_view.dart';
import '../../../menu/presentation/views/menu_view.dart';
import 'widgets/custom_nav_item.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int screenIndex = 0;

  List<Widget> get screens =>
      [
        const MenuView(),
        const OrderView(),
        const ReservationView(),
        const CustomerProfileScreen(),
      ];

  List<Widget> get customNavItems =>
      [
        const CustomNavItem(
          icon: FontAwesomeIcons.bookOpenReader,
          title: 'Menu',
        ),
        const CustomNavItem(
          icon: FontAwesomeIcons.cartPlus,
          title: 'Orders',
        ),
        const CustomNavItem(
          icon: FontAwesomeIcons.idCard,
          title: 'Reservation',
        ),
        const CustomNavItem(
          icon: Icons.verified_user_sharp,
          title: 'Profile',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.blue.withOpacity(0.8),
        items: customNavItems,
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
      ),
      body: screens[screenIndex],
    );
  }
}
