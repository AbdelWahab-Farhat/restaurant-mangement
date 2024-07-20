
import 'package:dartz/dartz.dart' as dartz;

import '../../../../models/employee.dart';
import '../../../../models/order/order.dart';
import '../../../../utility/errors/failure.dart';

abstract class StaticInfoRepo {
  Future<dartz.Either<Failure,List<Employee>>> fetchEmployees();
  Future<dartz.Either<Failure,List<Order>>> fetchOrders();
}