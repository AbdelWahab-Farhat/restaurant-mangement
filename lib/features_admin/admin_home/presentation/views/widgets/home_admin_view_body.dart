import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wid_healthy_food_restaurant/Features/auth/presentation/views/login_view.dart';
import 'package:wid_healthy_food_restaurant/utility/helpers.dart';

import '../../../../../utility/size_config.dart';
import '../../../../admin_menu/add_menu_item/add_menu_item_screen.dart';
import '../../../../admin_menu/remove_menu_item/remove_menu_item_screen.dart';
import '../../../../employee/presentation/views/add_employee_view.dart';
import '../../../../orderStatus/presentation/views/order_status_view.dart';
import '../../../../reservationsStatus/presentation/views/all_Reservations_view.dart';
import '../../../../staticInfo/prestation/views/static_info_view.dart';
import 'home_admin_box.dart';

class HomeAdminViewBody extends StatelessWidget {
  const HomeAdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().whenComplete(
                  () => pushReplacement(context, const LoginView()),);
              },
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  size: 25,
                ),
              ))
        ],
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: 20, right: 20, top: MediaQuery.sizeOf(context).height / 15),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: HomeAdminBox(
                    image: 'lib/assets/images/salad3.png',
                    viewName: 'Add Menu Item',
                    view: AddMenuItemScreen()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: HomeAdminBox(
                    image: 'lib/assets/images/salad2.png',
                    viewName: 'Remove Menu Item',
                    view: RemoveMenuItemScreen()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: HomeAdminBox(
                    image: 'lib/assets/images/salad4.png',
                    viewName: 'Add Employee',
                    view: AddEmployeeView()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: HomeAdminBox(
                    image: 'lib/assets/images/salad3.png',
                    viewName: 'Customer Reservations Status',
                    view: AllReservationsView()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: HomeAdminBox(
                    image: 'lib/assets/images/salad4.png',
                    viewName: 'Orders Status',
                    view: OrderStatusView()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: HomeAdminBox(
                    image: 'lib/assets/images/salad4.png',
                    viewName: 'Static Info',
                    view: StaticInfoView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
