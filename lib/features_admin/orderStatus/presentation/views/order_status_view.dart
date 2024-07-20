import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ReservationsStatus/data/repo/all_Reservations_repo.dart';
import '../../../reservationsStatus/data/repo/all_Reservations_repo_impl.dart';
import '../../data/Repo/order_status_repoImpl.dart';
import '../viewModel/order_status_cubit/order_status_cubit.dart';
import 'widgets/order_status_view_body.dart';

class OrderStatusView extends StatelessWidget {
  const OrderStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderStatusCubit(OrderStatusRepoImpl(),AllReservationsRepoImpl()),
      child: const OrderStatusViewBody(),
    );
  }
}
