import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons.dart';
import '../../../../../models/order/order.dart';
import '../../../../../models/reservation.dart';
import '../../../../../utility/helpers.dart';
import '../../viewModel/all_reservations_cubit.dart';
import '../reservation_order_view.dart';

class ReservationTile extends StatelessWidget {
  final Reservation reservation;
  final List<Order> userOrders;

  const ReservationTile(
      {super.key, required this.reservation, required this.userOrders});

  @override
  Widget build(BuildContext context) {
    Order  userOrder = context.read<AllReservationsCubit>().reservationOrder(reservation,userOrders);
    return ListTile(
      title: Text('Table: ${reservation.tableNumber}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reservation Date: ${formatDate(reservation.reservationDate)}'),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text('Time: ${reservation.time.format(context)}'),
              const Spacer(),
              CustomOutLinedButton(
                  width: 100,
                  height: 40,
                  onTap: () => push(context, ReservationOrderView(reservationUserOrder: userOrder)),
                  text: 'Order Info')
            ],
          ),
        ],
      ),
    );
  }
}
