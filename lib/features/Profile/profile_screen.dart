import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:restaurant_management/Features/Profile/profile_cubit.dart';
import 'package:restaurant_management/Features/Profile/side_profile_screens/edit_profile_screen.dart';
import 'package:restaurant_management/Features/Profile/side_profile_screens/order_history/order_History_screen.dart';
import 'package:restaurant_management/Features/Profile/side_profile_screens/review_screen.dart';
import 'package:restaurant_management/Features/Profile/side_profile_screens/setting_screen.dart';
import 'package:restaurant_management/Features/Profile/widgets/profile_menu_widget.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/core/widgets/custom_loading_widget.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/size_config.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  void initState() {
    // ADDED FROM LOGIN
    context.read<ProfileCubit>().loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: 'Profile', isCentred: true),
        body: Container(
          margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Center(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  return Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.space * 3,
                      ),
                      const Text(
                        'Welcome to restaurant',
                        style:
                            TextStyle(fontSize: 22, color: kDarkPrimaryColor),
                      ),
                      Text(
                        state.customer.userName,
                        style: const TextStyle(
                            fontSize: 14, color: kDarkSecondaryColor),
                      ),
                      SizedBox(
                        height: SizeConfig.space * 6,
                      ),
                      ProfileMenuWidget(
                        title: 'setting',
                        icon: Icons.settings_outlined,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SettingScreen(customer: state.customer),
                            )),
                      ),
                      SizedBox(
                        height: SizeConfig.space * 3,
                      ),
                      ProfileMenuWidget(
                        title: 'Edit Profile',
                        icon: Icons.edit_outlined,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                customer: state.customer,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: SizeConfig.space * 3,
                      ),
                      ProfileMenuWidget(
                        title: 'Review Restaurant',
                        icon: LineAwesomeIcons.receipt_solid,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReviewScreen(),
                            )),
                      ),
                      SizedBox(
                        height: SizeConfig.space * 3,
                      ),
                      ProfileMenuWidget(
                        title: 'Order History',
                        icon: Icons.history,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderHistoryScreen(),
                            )),
                      ),
                      SizedBox(
                        height: SizeConfig.space * 3,
                      ),
                      ProfileMenuWidget(
                        title: 'Notifications',
                        icon: LineAwesomeIcons.bell,
                        onPress: () {},
                      )
                    ],
                  );
                } else if (state is ProfileLoading) {
                  return const CustomLoadingWidget();
                } else if (state is ProfileError) {
                  return Center(child: Text(state.message));
                }
                return const Center(
                    child: Text(
                        'Error Loading User, Check Your Internet Connection and try again'));
              },
            ),
          ),
        ));
  }
}
