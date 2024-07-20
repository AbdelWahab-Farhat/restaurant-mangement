import 'package:dartz/dartz.dart';

import '../../../../models/order/orderItem.dart';
import '../../../../utility/errors/failure.dart';


abstract class OrderRepo {
  Future<Either<Failure,List<OrderItem>>> fetchUserOrderItems();
  Future<Either<Failure,List<OrderItem>>> removeOrderItem(List<OrderItem> orderItems ,OrderItem orderItem);
}