import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../utility/size_config.dart';
import '../../viewModel/menu_cubit/menu_cubit.dart';
import 'left_column_design_widget.dart';
import 'menu_list_view.dart';


class MenuBody extends StatefulWidget {
  const MenuBody({super.key});

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  @override
  void initState() {
    context.read<MenuCubit>().fetchMenus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Menu', isCentred: true),
      body: Container(
        margin: EdgeInsets.only(top: SizeConfig.space),
        child: const Stack(
          children: [
            LeftColumnDesignWidget(),
            MenuListView(),
          ],
        ),
      ),
    );
  }
}
