import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/Features/auth/login/login_cubit.dart';
import 'package:restaurant_management/Features/home/menus/menu_cubit.dart';
import 'package:restaurant_management/Features/home/menus/menu_detail_screen.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/core/widgets/custom_cached_Image.dart';
import 'package:restaurant_management/models/menu/menu.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/helpers.dart';
import 'package:restaurant_management/utility/size_config.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double radiusRight = 38;
    Widget designContent = Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: SizeConfig.space * 9.7,
        height: SizeConfig.space * 52,
        decoration: BoxDecoration(
            color: kDarkPrimaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(radiusRight),
                bottomRight: Radius.circular(radiusRight))),
      ),
    );
    return Scaffold(
      appBar: const CustomAppbar(title: 'Menu', isCentred: true),
      body: Container(
        margin: EdgeInsets.only(top: SizeConfig.space),
        child: Stack(
          children: [
            designContent,
            BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state is MenuLoaded) {
                  return Column(
                    children:
                        state.menus.map((menu) => menuItem(context , menu)).toList(),
                  );
                } else if (state is MenuLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.redAccent),
                  );
                } else if (state is MenuError) {
                  designContent = const SizedBox();
                  return const Center(
                    child: Text(
                      'Check your Internet And Try Again',
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Unknown Error'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(BuildContext context ,Menu menu) {
    double radiusLeftSide = 30;
    double radiusRightSide = 15;
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MenuDetailScreen(items: menu.menuItems!, menuName: menu.menuName);
      },)),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLeftSide),
                      bottomLeft: Radius.circular(radiusLeftSide),
                      topRight: Radius.circular(radiusRightSide),
                      bottomRight: Radius.circular(radiusRightSide),
                    ),
                    child: SizedBox(
                      width: SizeConfig.screenWidth / 1.2,
                      height: SizeConfig.screenHeight / 9,
                      child: Row(
                        children: [
                          SizedBox(width: SizeConfig.screenWidth / 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.menuName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Items: ${menu.numberOfItems}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 4, left: 10),
                    clipBehavior: Clip.hardEdge,
                    height: SizeConfig.space * 8,
                    width: SizeConfig.space * 8,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    // Placeholder Image Later
                    child: CustomCachedImage(
                      imageUrl: menu.menuItems![0].itemImageURL,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.9, 0),
                  heightFactor: 2.8,
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: SizeConfig.space * 3,
                      height: SizeConfig.space * 3,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: SizeConfig.space * 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
