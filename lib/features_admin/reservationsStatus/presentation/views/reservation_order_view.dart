import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/order/order.dart';
import '../../data/repo/all_Reservations_repo_impl.dart';
import '../viewModel/all_reservations_cubit.dart';
import 'widgets/reservation_order_view_body.dart';

class ReservationOrderView extends StatelessWidget {
  final Order reservationUserOrder;

  const ReservationOrderView({super.key, required this.reservationUserOrder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllReservationsCubit(AllReservationsRepoImpl()),
      child: ReservationOrderViewBody(order: reservationUserOrder,),
    );
  }
}
