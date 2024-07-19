import 'package:dartz/dartz.dart' as dartz;
import 'package:cloud_firestore/cloud_firestore.dart' as st;
import 'package:firebase_auth/firebase_auth.dart' as frAuth;
import 'package:restaurant_management/models/user/customer.dart' as cust;
import 'package:restaurant_management/models/user/user.dart';
import 'package:restaurant_management/models/reservation.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';
import 'package:restaurant_management/utility/errors/failure.dart';


class Resev {
  final st.FirebaseFirestore store;
  final frAuth.FirebaseAuth auth;

  Resev({required this.store, required this.auth});

  Future<dartz.Either<Failure, cust.Customer>> fetchUserReservations() async {
    try {
      final data  = await store.collection('users').doc(auth.currentUser!.uid).get();
      if (data.data()!['role'] == Role.customer.name) {
        cust.Customer customer = cust.Customer.fromJson(data.data()!);
        return dartz.right(customer);
      }
      else {
        return dartz.left(FailureService(errMessage: 'Could not fetch User')
        );
      }
    } catch (e) {
      print('Error fetching user reservations: $e');
      return dartz.left(FailureService(errMessage: 'Could not fetch data'));
    }
  }
}
