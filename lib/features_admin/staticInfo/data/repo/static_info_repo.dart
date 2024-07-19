
import 'package:dartz/dartz.dart' as dartz;
import 'package:restaurant_management/utility/errors/failure.dart';

import '../../../../models/employee.dart';
import '../../../../models/order/order.dart';

abstract class StaticInfoRepo {
  Future<dartz.Either<Failure,List<Employee>>> fetchEmployees();
  Future<dartz.Either<Failure,List<Order>>> fetchOrders();
}