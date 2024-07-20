import 'package:flutter/material.dart';

import '../../../../../models/user/customer.dart';
import 'reservationt_tile.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    if (customer.reservations == null) {
      return const SizedBox();
    }
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
            title: Text("Name:${customer.userName}"),
            subtitle: Text("Phone Number: ${customer.phoneNumber}"),
            childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: customer.reservations != null
                ? customer.reservations!
                .map((res) => ReservationTile(reservation: res, userOrders: customer.orders ?? [],))
                .toList()
                : [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No reservations'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
