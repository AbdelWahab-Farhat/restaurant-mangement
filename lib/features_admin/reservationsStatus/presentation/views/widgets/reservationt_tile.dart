import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/presentation/views/reservation_order_view.dart';
import 'package:restaurant_management/features_admin/orderStatus/presentation/views/order_status_view.dart';

import '../../../../../models/order/order.dart';
import '../../../../../models/reservation.dart';
import '../../../../../utility/app_style.dart';
import '../../../../../utility/helpers.dart';
import '../../viewModel/all_reservations_cubit.dart';

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
