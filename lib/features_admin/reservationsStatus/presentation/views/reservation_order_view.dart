import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/data/repo/all_Reservations_repo_impl.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/viewModel/all_reservations_cubit.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/views/widgets/reservation_order_view_body.dart';

import '../../../../models/order/order.dart';

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
