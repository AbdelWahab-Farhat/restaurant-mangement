import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user/customer.dart';
import '../../models/user/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading()) {
    loadUser();
  }

  Future<void> loadUser() async {
    emit(ProfileLoading());
    try {
      User? user = await FirebaseService().getUser();
      if (user is Customer) {
        emit(ProfileSuccess(customer: user));
      } else {
        emit(ProfileError(message: 'Error Loading Profile, Weak Internet.'));
      }
    } catch (e) {
      emit(ProfileError(message: 'Error Loading Profile, Weak Internet.'));
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