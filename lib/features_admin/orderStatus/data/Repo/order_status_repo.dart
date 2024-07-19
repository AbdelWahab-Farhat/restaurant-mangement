

import 'package:dartz/dartz.dart';

import '../../../../models/order/order.dart' as or;
import '../../../../utility/errors/failure.dart';

abstract class OrderStatusRepo {
  Future<Either<Failure,List<or.Order>>> fetchOrders();

}