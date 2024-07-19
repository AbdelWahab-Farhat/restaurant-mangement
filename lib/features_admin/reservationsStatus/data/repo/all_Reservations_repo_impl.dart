
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_management/features_admin/ReservationsStatus/data/repo/all_Reservations_repo.dart';
import 'package:restaurant_management/models/user/customer.dart';
import 'package:restaurant_management/utility/errors/failure.dart';

class AllReservationsRepoImpl extends AllReservationsRepo{
  @override
  Future<Either<Failure, List<Customer>>> fetchCustomers() async {
    try {
      List<Customer> customers  = [];
      final queryDocs = await FirebaseFirestore.instance.collection('users').get();
      for (var doc in queryDocs.docs) {
        if (doc.data()['role'] == 'customer'){
          customers.add(Customer.fromJson(doc.data()));
        }
      }
      return right(customers);
    } on FirebaseException catch (e) {
      return left(FailureService(errMessage: e.code));
    }
  }

}