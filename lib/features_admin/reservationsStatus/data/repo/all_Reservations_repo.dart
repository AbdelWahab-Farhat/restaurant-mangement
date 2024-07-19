
import 'package:dartz/dartz.dart';
import 'package:restaurant_management/models/user/customer.dart';
import 'package:restaurant_management/utility/errors/failure.dart';

abstract class AllReservationsRepo {
  Future<Either<Failure,List<Customer>>> fetchCustomers();
}