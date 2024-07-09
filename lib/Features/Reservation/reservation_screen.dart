import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/models/user/customer.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/helpers.dart';
import '../../Blocs/reservation_bloc/reservation_bloc.dart';
import '../../models/order/order.dart';
import '../../models/reservation.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ReservationBloc>().add(LoadReservationEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Reservation', isCentred: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<ReservationBloc,ReservationState>(
          builder: (context, state) {
            if (state is ReservationSuccess) {
              if (state.reservations.isEmpty) {
                return const Center(child: Text('No At the Moment Reservation'),);
              }
              else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.reservations.length,
                  itemBuilder: (context, index) {
                    return _reservationItem(
                        context, state.reservations[index], state.customer ,index);
                  },
                );
              }
            }
            else if (state is ReservationError) {
              return Center(child: Text(state.massage),);
            }
            else if (state is ReservationLoading) {
              return const Center(child: CircularProgressIndicator(color: kDarkPrimaryColor,),);
            }
            else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _reservationItem(
      BuildContext ctx, Reservation rev, Customer customer, int index) {
    // reservationOrder
    Order? order = rev.reservationOrder(customer.orders!);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Reservation ${index+1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kDarkPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                   Text(
                    'Name : ${customer.userName}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kDarkPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Table Number : ${rev.tableNumber}',
                    style: TextStyle(
                      fontSize: 14,
                      color: kDarkSecondaryColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatDate(rev.reservationDate),
                    style: TextStyle(
                      fontSize: 14,
                      color: kDarkSecondaryColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    rev.time.format(context),
                    style: TextStyle(
                      fontSize: 14,
                      color: kDarkSecondaryColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 5),
                   Text(
                    'Paid ${order!.totalPrice.toStringAsFixed(2)} LY',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kDarkSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
