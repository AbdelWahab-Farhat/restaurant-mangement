import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_management/features/Order/data/repo/order_repo.dart';
import 'package:restaurant_management/models/order/orderItem.dart';
import 'package:restaurant_management/utility/errors/failure.dart';

class OrderRepoImpl extends OrderRepo {
  final FirebaseFirestore store;
  final FirebaseAuth auth;

  OrderRepoImpl({required this.store, required this.auth});
  @override
  Future<Either<Failure, List<OrderItem>>> fetchUserOrderItems() async {
    List<OrderItem> items = [];
    try {
      final querySnapShot = await store.collection('orderItems').get();
      for (var doc in querySnapShot.docs) {
        final OrderItem orderItem = OrderItem.fromJson(doc.data());
        if (orderItem.userID == auth.currentUser!.uid) {
          items.add(orderItem);
        }
      }
      return right(items);
    } on FirebaseException catch (error) {
      return left(FailureService(errMessage: error.code));
    }
  }

  @override
  Future<Either<Failure, List<OrderItem>>> removeOrderItem(
      List<OrderItem> orderItems, OrderItem orderItem) async {
    List<OrderItem> newOrderItems = [];
    try {
      final query = await store.collection('orderItems').get();
      for (var doc in query.docs) {
        OrderItem item = OrderItem.fromJson(doc.data());
        if (item.orderItemId == orderItem.orderItemId) {
          await store.collection('orderItems').doc(orderItem.itemID).delete();
        }
      }
      for (var doc in query.docs) {
        OrderItem item = OrderItem.fromJson(doc.data());
        newOrderItems.add(item);
      }
      return right(newOrderItems);
    } on FirebaseException catch (error) {
      return Left(FailureService(errMessage: error.code));
    }
  }
}
