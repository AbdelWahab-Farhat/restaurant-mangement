import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../viewModel/reservation_cubit/reservation_cubit.dart';
import 'widgets/reservation_body.dart';


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
