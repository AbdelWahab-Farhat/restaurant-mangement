import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features/Reservation/data/repo/reservation_repo_impl.dart';
import 'package:restaurant_management/features/Reservation/presentation/views/widgets/reservation_body.dart';

import '../viewModel/reservation_cubit/reservation_cubit.dart';


class ReservationView extends StatelessWidget {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationCubit(),
      child: const ReservationBody(),
    );
  }
}
