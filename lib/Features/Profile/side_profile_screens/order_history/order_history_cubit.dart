import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fire;
import 'package:meta/meta.dart';
import 'package:restaurant_management/models/order/order.dart' ;
import 'package:restaurant_management/models/user/customer.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/user/user.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial()){
    fetchOrders();
  }



  Future<void> fetchOrders() async {
    emit(OrderHistoryLoading());
    final sp = await SharedPreferences.getInstance();
    sp.remove('user');
    User? user = await FirebaseService().getUser();
    if (user is Customer) {
      Customer customer = user;
      if (customer.orders == null || customer.orders!.isEmpty) {
        emit(OrderHistoryError(message: 'NO History'));
      }
      else {
        emit(OrderHistorySuccess(userOrders: customer.orders!));
      }
    }
    }
  }
