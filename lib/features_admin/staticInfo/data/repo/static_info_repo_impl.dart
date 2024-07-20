
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:dartz/dartz.dart' as dartz;

import '../../../../models/employee.dart';
import '../../../../models/order/order.dart';
import '../../../../utility/errors/failure.dart';
import 'static_info_repo.dart';

class StaticInfoRepoImpl extends StaticInfoRepo {
  @override
  Future<dartz.Either<Failure, List<Employee>>> fetchEmployees()async {
    List<Employee> employees = [];
    try {
      final query = await store.FirebaseFirestore.instance.collection('employees').get();
      for (var item in query.docs) {
        employees.add(Employee.fromJson(item.data()));
      }
      return dartz.right(employees);
    } on store.FirebaseException catch (e) {
      return dartz.left(FailureService(errMessage: e.code));
    }
  }

  @override
  Future<dartz.Either<Failure, List<Order>>> fetchOrders() async {
    List<Order> orders = [];
    try {
      final query = await store.FirebaseFirestore.instance.collection('orders').get();
      for (var item in query.docs) {
        orders.add(Order.fromJson(item.data()));
      }
      return dartz.right(orders);
    } on store.FirebaseException catch (e) {
      return dartz.left(FailureService(errMessage: e.code));
    }
  }

}