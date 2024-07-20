import 'package:flutter/material.dart';

import '../../../../../models/reservation.dart';
import '../../../../../models/user/customer.dart';
import 'reservation_Item_widget.dart';

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