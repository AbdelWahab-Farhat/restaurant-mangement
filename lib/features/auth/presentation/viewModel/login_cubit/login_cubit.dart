import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:wid_healthy_food_restaurant/features/auth/data/repo/auth_repo_impl.dart';


import '../../../../../models/user/user.dart' as u;
import '../../../data/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepoImpl authRepo = AuthRepoImpl(auth: FirebaseAuth.instance, store: FirebaseFirestore.instance);
  u.User? currentUser;

  LoginCubit() : super(const LoginInitial());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(const LoginLoadingState());
    var result = await authRepo.loginWithEmailAndPassword(email: email, password: password);
    result.fold((failure) => emit(LoginFailureState(message: failure.errMessage)),(user) {
      emit(const LoginSuccessState());
      currentUser = user;
    },);
  }
}
