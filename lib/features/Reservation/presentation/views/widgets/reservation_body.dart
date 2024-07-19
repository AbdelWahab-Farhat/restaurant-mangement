import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features/Reservation/presentation/views/widgets/reservation_List_view.dart';

import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../models/user/customer.dart';
import '../../../../../utility/constents.dart';
import '../../viewModel/reservation_cubit/reservation_cubit.dart';


class ReservationBody extends StatefulWidget {
  const ReservationBody({super.key});

  @override
  State<ReservationBody> createState() => _ReservationBodyState();
}

class _ReservationBodyState extends State<ReservationBody> {
  @override
  void initState() {
    context.read<ReservationCubit>().fetchReservations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(title: 'Reservation', isCentred: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<ReservationCubit, ReservationState>(
          builder: (context, state) {
            if (state is ReservationSuccess) {
              if (state.customer.reservations == null) {
                return const Center(
                  child: Text('No Reservations At the Moment'),
                );
              } else {
                return ReservationListView(
                  reservations: state.customer.reservations!, customer: state.customer,);
              }
            } else if (state is ReservationFailure) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: kDarkPrimaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

