import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user/customer.dart';
import '../../models/user/user.dart';
import '../../services/FirebaseServices/fireStore_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  Future<void> loadUser() async {
    emit(ProfileLoading());
    try {
      final data  = await FirebaseFirestore.instance.collection('users').doc(auth.FirebaseAuth.instance.currentUser!.uid).get();
      if (data.data()!['role'] == Role.customer.name) {
        Customer customer = Customer.fromJson(data.data()!);
        emit(ProfileSuccess(customer: customer));
      }
      else {
        emit(ProfileError(message: 'error'));
      }
    } catch (e) {
      print('Error fetching user reservations: $e');
      emit(ProfileError(message: 'network error'));
    }
  }
  Future<void> updateUser(Customer customer, String oldPassword) async {
    emit(ProfileLoading());
    bool success = await FirebaseService().updateCustomer(customer ,oldPassword );
    if (success) {
      final oldDataUser  = await SharedPreferences.getInstance();
      if(oldDataUser.containsKey('user')) {
        oldDataUser.remove('user');
      }
      emit(ProfileSuccess(customer: customer));
    } else {
      emit(ProfileError(message: 'Failed to update data. Please try again later.'));
    }
  }
}