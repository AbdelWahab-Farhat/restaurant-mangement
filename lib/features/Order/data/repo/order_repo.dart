import 'package:dartz/dartz.dart';
import 'package:restaurant_management/models/order/orderItem.dart';
import 'package:restaurant_management/utility/errors/failure.dart';

abstract class OrderRepo {
  Future<Either<Failure,List<OrderItem>>> fetchUserOrderItems();
  Future<Either<Failure,List<OrderItem>>> removeOrderItem(List<OrderItem> orderItems ,OrderItem orderItem);
}