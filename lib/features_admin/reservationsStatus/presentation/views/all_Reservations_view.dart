import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/data/repo/all_Reservations_repo_impl.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/viewModel/all_reservations_cubit.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/views/widgets/All_Reservations_View_body.dart';


class AllReservationsView extends StatelessWidget {
  const AllReservationsView({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllReservationsCubit(AllReservationsRepoImpl()),
      child: const AllReservationsViewBody(),
    );
  }
}
