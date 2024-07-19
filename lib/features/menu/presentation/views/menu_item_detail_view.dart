import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features/menu/presentation/views/widgets/menu_item_detail_view_body.dart';

import '../../../../models/item.dart';
import '../../data/repo/menu_repo_impl.dart';
import '../viewModel/menu_detail_item/menu_detail_item_cubit.dart';
import '../viewModel/price_cubit/price_cubit.dart';

class MenuItemDetailView extends StatelessWidget {
  final Item item;

  const MenuItemDetailView({super.key, required this.item});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MenuDetailItemCubit(
                MenuRepoImpl(store: FirebaseFirestore.instance),),
        ),
        BlocProvider(
          create: (context) =>
              PriceCubit()),
      ],
      child: MenuItemDetailViewBody(item: item,),
    );
  }
}
