import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';

import '../../models/order/orderItem.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  bool isLoaded = false;
  OrderBloc() : super(OrderInitial(orderItems: [])) {
    on<AddOrderItemEvent>((event, emit) async {
      emit(OrderLoading());
      bool result = await FirebaseService().addItemOrder(event.orderItem);
      if (result) {
        List<OrderItem>? orderItems = await FirebaseService().loadUserOrderItems();
        if (orderItems == null) {
          emit(OrderError(massage: "Error Fetching Cart"));
        } else {
          emit(OrderSuccess(orderItems: orderItems));
        }
      } else {
        emit(OrderError(massage: "Error Adding Item"));
      }
    });
    on<LoadOrderItemsEvent>((event, emit) async {
      emit(OrderLoading());
      List<OrderItem>? orderItems = await FirebaseService().loadUserOrderItems();
      if (orderItems == null) {
        isLoaded = false;
        emit(OrderError(massage: 'Error Loading Items'));
      } else {
        isLoaded = true;
        emit(OrderInitial(orderItems: orderItems));
      }
    });
    on<RemoveOrderItemEvent>((event, emit) async {
      emit(OrderLoading());
      bool result = await FirebaseService().removeItemOrder(event.orderItem);
      if (result) {
        List<OrderItem>? orderItems = await FirebaseService().loadUserOrderItems();
        if (orderItems != null) {
          emit(OrderSuccess(orderItems: orderItems));
        }
        else {
          emit(OrderError(massage: 'Error Fetching data'));
        }
      }
      else {
        emit(OrderError(massage: 'Error Fetching data'));
      }
    });

  }
}
