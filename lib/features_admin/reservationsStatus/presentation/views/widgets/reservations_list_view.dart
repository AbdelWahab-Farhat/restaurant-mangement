import 'package:flutter/material.dart';

import '../../../../../models/user/customer.dart';
import 'customer_card.dart';

class ReservationsListView extends StatelessWidget {
  final List<Customer> customers;
  const ReservationsListView({
    super.key, required this.customers,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        Customer customer = customers[index];
        return CustomerCard(customer: customer);
      },
    );
  }
}

