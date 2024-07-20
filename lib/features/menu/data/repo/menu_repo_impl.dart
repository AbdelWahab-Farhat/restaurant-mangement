
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../models/menu/menu.dart';
import '../../../../models/order/orderItem.dart';
import '../../../../utility/errors/failure.dart';
import 'menu_repo.dart';


class MenuRepoImpl extends MenuRepo{
  final FirebaseFirestore store;
  MenuRepoImpl({required this.store});

  @override
  Future<Either<Failure, List<Menu>>> fetchMenus() async {
      try {
        final querySnapshot = await store.collection('menus').get();
        List<Menu> menus = querySnapshot.docs.map((doc) {
          return Menu.fromJson(doc.data());
        }).toList();
        return right(menus);
      }
      catch (e) {
        if (e is FirebaseException) {
          return left(FailureService(errMessage: e.code));
        }
        else {
          return left(FailureService(errMessage: 'Oops,Error happened'));
        }
      }
    }

  @override
  Future<Either<Failure, String>> addItemFromMenuToOrder(OrderItem orderItem) async{
    try {
      // Check if the item already exists
      var itemSnapshot = await store.collection('orderItems').doc(orderItem.itemID).get();

      if (itemSnapshot.exists) {
        // Item exists, update the quantity
        int currentQuantity = itemSnapshot['quantity'] ?? 0;
        int newQuantity = currentQuantity + orderItem.quantity;
        // Update the item with new quantity
        await store.collection('orderItems').doc(orderItem.itemID).update({
          'quantity': newQuantity,
        });
        return right('Item added to Order Successfully');
      } else {
        await store
            .collection('orderItems')
            .doc(orderItem.itemID)
            .set(orderItem.toJson());
        return right('Item added to Order Successfully');
      }
    } catch (e) {
      return left(FailureService(errMessage: 'Error Adding Item to Order.'));
      }
   }
  }
