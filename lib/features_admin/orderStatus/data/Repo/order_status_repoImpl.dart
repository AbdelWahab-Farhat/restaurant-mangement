

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' ;
import '../../../../models/order/order.dart' as or;
import '../../../../utility/errors/failure.dart';
import 'order_status_repo.dart';

class OrderStatusRepoImpl extends OrderStatusRepo{
  @override
  Future<Either<Failure, List<or.Order>>> fetchOrders() async {
    try {
      List<or.Order> orders  = [];
      final query = await  FirebaseFirestore.instance.collection('orders').get();
      for (var doc in query.docs) {
        or.Order order = or.Order.fromJson(doc.data());
        orders.add(order);
      }
      return right(orders);
    } on FirebaseException catch (e) {
      return left(FailureService(errMessage: e.code));
    }
  }
}