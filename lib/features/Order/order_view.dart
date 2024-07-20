import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repo/order_repo_impl.dart';
import 'presentation/viewModel/order_cubit.dart';
import 'presentation/views/widgets/order_view_body.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(
          create: (context) =>
              OrderCubit(OrderRepoImpl(
                store: FirebaseFirestore.instance,
                auth: FirebaseAuth.instance,
              )),
        ),
      ],
      child: OrderViewBody(),
    );
  }
}
