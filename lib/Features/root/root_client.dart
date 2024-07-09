import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/Features/Auth/login/login_cubit.dart';
import 'package:restaurant_management/Features/Reservation/reservation_screen.dart';
import 'package:restaurant_management/utility/size_config.dart';
import '../Order/order_screen.dart';
import '../Profile/profile_screen.dart';
import '../home/menus/menu_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int screenIndex = 0;
  List<Widget> screens = [
    const MenuScreen(),
    const OrderScreen(),
    const ReservationScreen(),
    const CustomerProfileScreen(),
  ];
  List<Widget> icons = [
    const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(Icons.menu_book_outlined),
          Text('Menu', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
    const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(Icons.receipt_long_outlined),
          Text('Orders', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
        ],
      ),
    ),
    const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(Icons.event_available),
          Text('Reservations', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
        ],
      ),
    ),
    const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(Icons.person_outline),
          Text('Profile', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.blue.withOpacity(0.8),
        items: icons,
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
