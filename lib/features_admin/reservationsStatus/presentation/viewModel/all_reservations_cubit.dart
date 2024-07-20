import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:meta/meta.dart';

import '../../../../models/order/order.dart';
import '../../../../models/reservation.dart';
import '../../../../models/user/customer.dart';
import '../../data/repo/all_Reservations_repo.dart';

part 'all_reservations_state.dart';

class AllReservationsCubit extends Cubit<AllReservationsState> {
  final AllReservationsRepo allReservationsRepo;
  AllReservationsCubit(this.allReservationsRepo)
      : super(AllReservationsInitial());

  Future<void> fetchCustomers() async {
    emit(AllReservationsLoading());
    var result = await allReservationsRepo.fetchCustomers();
    result.fold(
      (failure) => emit(AllReservationsFailure(errMessage: failure.errMessage)),
      (customers) => emit(AllReservationsSuccess(customers: customers)),
    );
  }

  Order reservationOrder(Reservation reservation, List<Order> orders) {
    for (var order in orders) {
      if (reservation.orderID == order.orderID) {
        return order;
      }
    }
    return orders.first;
  }

  Future<void> changeOrderState(Order order, OrderStatus status) async {
    try {
      order.orderStatus = status;
      await store.FirebaseFirestore.instance
          .collection('orders')
          .doc(order.orderID)
          .update({'orderStatus': order.orderStatus.name});

      var query = await store.FirebaseFirestore.instance
          .collection('users')
          .where('customerID', isEqualTo: order.customerID)
          .get();

      if (query.docs.isNotEmpty && query.docs.first.data()['role'] == 'customer') {
        Customer customer = Customer.fromJson(query.docs.first.data());
        for (var item in customer.orders!) {
          if (item.orderID == order.orderID) {
            item.orderStatus = status; // Update the order status here
            break;
          }
        }
        await store.FirebaseFirestore.instance
            .collection('users')
            .doc(customer.userID)
            .update({
          'orders': customer.orders!.map((e) => e.toJson()).toList(),
        });
      } else {
        throw Exception("Customer not found or role is not 'customer'.");
      }
    } catch (e) {
      print('Error changing order state: $e');
      // Handle the error by showing a message to the user, logging it, etc.
      // You can rethrow the error or handle it as per your requirement
      throw e; // Optional: rethrow the error to be handled by the calling function
    }
  }
}
