
import 'package:dartz/dartz.dart';


import '../../../../models/menu/menu.dart';
import '../../../../models/order/orderItem.dart';
import '../../../../utility/errors/failure.dart';

abstract class MenuRepo {
  Future<Either<Failure,List<Menu>>> fetchMenus();
  Future<Either<Failure,String>> addItemFromMenuToOrder(OrderItem orderItem);
}