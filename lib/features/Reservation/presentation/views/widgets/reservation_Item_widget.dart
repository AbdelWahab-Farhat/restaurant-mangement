import 'package:flutter/material.dart';

import '../../../../../models/order/order.dart';
import '../../../../../models/reservation.dart';
import '../../../../../models/user/customer.dart';
import '../../../../../utility/constents.dart';
import '../../../../../utility/helpers.dart';

class ReservationItemWidget extends StatelessWidget {
  final Reservation reservation;
  final Customer customer;
  const ReservationItemWidget({super.key, required this.reservation, required this.customer});

  @override
  Widget build(BuildContext context) {
    Order? order = reservation.reservationOrder(customer.orders!);
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
                    'Name : ${customer.userName}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kDarkPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Table Number : ${reservation.tableNumber}',
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
                    formatDate(reservation.reservationDate)!,
                    style: TextStyle(
                      fontSize: 14,
                      color: kDarkSecondaryColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    reservation.time.format(context),
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
