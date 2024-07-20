import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/order/orderItem.dart';
import '../../data/repo/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;
  List<OrderItem> cubitOrderItems = [];
  OrderCubit(this.orderRepo) : super(OrderInitial());

  Future<void> fetchUserOrderItems() async {
    cubitOrderItems.clear();
    emit(OrderLoading());
    var result = await orderRepo.fetchUserOrderItems();
    result.fold(
      (failure) => emit(OrderFailure(errMessage: failure.errMessage)),
      (orderItems) {
        cubitOrderItems = orderItems;
        emit(OrderSuccess(orderItems: cubitOrderItems));
      },
    );
  }
  Future<void> removeOrderItem(
      List<OrderItem> orderItems, OrderItem orderItem) async {
    cubitOrderItems.clear();
    emit(OrderLoading());
    var result = await orderRepo.removeOrderItem(orderItems, orderItem);
    result.fold(
      (failure) => OrderFailure(errMessage: failure.errMessage),
      (orderItems) {
        fetchUserOrderItems();
      },
    );
  }
}
