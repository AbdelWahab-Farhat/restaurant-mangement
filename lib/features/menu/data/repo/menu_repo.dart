
import 'package:dartz/dartz.dart';
import 'package:restaurant_management/models/menu/menu.dart';
import 'package:restaurant_management/utility/errors/failure.dart';

import '../../../../models/order/orderItem.dart';

abstract class MenuRepo {
  Future<Either<Failure,List<Menu>>> fetchMenus();
  Future<Either<Failure,String>> addItemFromMenuToOrder(OrderItem orderItem);
}