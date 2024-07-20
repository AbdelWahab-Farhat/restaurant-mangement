
import 'package:dartz/dartz.dart';

import '../../../../models/user/customer.dart';
import '../../../../utility/errors/failure.dart';


abstract class AllReservationsRepo {
  Future<Either<Failure,List<Customer>>> fetchCustomers();
}