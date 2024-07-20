import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/menu_repo_impl.dart';
import '../viewModel/menu_cubit/menu_cubit.dart';
import 'widgets/menu_body.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuCubit>(
          create: (context) =>
              MenuCubit(
                MenuRepoImpl(store: FirebaseFirestore.instance),
              ),
        ),
      ],
      child: MenuBody(),
    );
  }
}

