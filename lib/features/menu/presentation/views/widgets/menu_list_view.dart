import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../viewModel/menu_cubit/menu_cubit.dart';
import 'menu_item_list_view.dart';


class MenuListView extends StatelessWidget {
  const MenuListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        if (state is MenuSuccess) {
          return Column(
            children: state.menus.map((menu) => MenuItemListView(menu: menu,)).toList(),
          );
        }
        else if (state is MenuFailure) {
          return CustomErrorWidget(errMessage: state.message);
        }
        else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
