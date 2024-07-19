import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../models/order/order.dart';
import '../../../../../models/user/customer.dart';
import '../../../../ReservationsStatus/data/repo/all_Reservations_repo.dart';
import '../../../data/Repo/order_status_repo.dart';

part 'order_status_state.dart';

class OrderStatusCubit extends Cubit<OrderStatusState> {
  final OrderStatusRepo orderStatusRepo;
  final AllReservationsRepo allReservationsRepo;
  List<Customer> customers = [];
  OrderStatusCubit(this.orderStatusRepo, this.allReservationsRepo)
      : super(OrderStatusInitial());

  void fetchOrders() async {
    emit(OrderStatusLoading());
    var result = await orderStatusRepo.fetchOrders();
    result.fold(
      (failure) => emit(OrderStatusFailure(errMessage: failure.errMessage)),
      (orders) => emit(OrderStatusSuccess(orders: orders)),
    );
  }

  List<Order> getOrdersByStatus(List<Order> orders, OrderStatus state) {
    List<Order> filteredOrders = [];
    for (var order in orders) {
      if (order.orderStatus == state) {
        filteredOrders.add(order);
      }
    }
    return filteredOrders;
  }

  void fetchCustomersForEachOrder() async {
    emit(OrderStatusLoading());
    var result = await allReservationsRepo.fetchCustomers();
    result.fold(
      (failure) => emit(OrderStatusFailure(errMessage: failure.errMessage)),
      (custs) => customers = custs,
    );
  }
  Customer? getCustomerByOrder(Order order) {
    for (var customer in customers){
      if (customer.customerID == order.customerID) {
        return customer;
      }
    }
    return null;
  }
}
