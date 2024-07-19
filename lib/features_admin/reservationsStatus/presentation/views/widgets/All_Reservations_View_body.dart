import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/core/widgets/custom_error_widget.dart';
import 'package:restaurant_management/core/widgets/custom_loading_widget.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/viewModel/all_reservations_cubit.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/views/widgets/reservations_list_view.dart';

class AllReservationsViewBody extends StatefulWidget {
  const AllReservationsViewBody({super.key});

  @override
  State<AllReservationsViewBody> createState() =>
      _AllReservationsViewBodyState();
}

class _AllReservationsViewBodyState extends State<AllReservationsViewBody> {
  @override
  void initState() {
    context.read<AllReservationsCubit>().fetchCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Customers Reservations'),
      ),
      body: BlocBuilder<AllReservationsCubit, AllReservationsState>(
        builder: (context, state) {
          if (state is AllReservationsSuccess) {
            return  ReservationsListView(customers: state.customers,);
          } else if (state is AllReservationsFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}


