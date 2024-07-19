import 'package:flutter/material.dart';
import 'package:restaurant_management/features/Reservation/presentation/views/widgets/reservation_Item_widget.dart';

import '../../../../../models/reservation.dart';
import '../../../../../models/user/customer.dart';

class ReservationListView extends StatelessWidget {
  final List<Reservation> reservations;
  final Customer customer;
  const ReservationListView({super.key, required this.reservations, required this.customer});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: reservations.length,
      itemBuilder: (ctx, index) {
        return ReservationItemWidget(
          reservation: reservations[index],
          customer: customer,
        );
      },
    );
  }
}