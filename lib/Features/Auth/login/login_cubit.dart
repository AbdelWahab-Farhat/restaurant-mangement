import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_management/models/user/user.dart' as u;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth firebaseAuth;
  u.User? currentUser;

  LoginCubit({required this.firebaseAuth}) : super(const LoginInitial());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(const LoginLoadingState());
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        emit(const LoginErrorState(message: 'Please check your email to verify it.'));
      } else if (user != null && user.emailVerified) {
        final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        // Not nesc.
        if (docSnapshot.exists) {
          currentUser = u.User.fromJson(docSnapshot.data()!);
          emit(const LoginSuccessState(message: "Login successful!"));
        } else {
          emit(const LoginErrorState(message: 'User data not found in Database.'));
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'user-disabled':
          errorMessage = 'The user corresponding to the given email has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'There is no user corresponding to the given email.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is invalid for the given email.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
      }
      emit(LoginErrorState(message: errorMessage));
    } catch (e) {
      emit(const LoginErrorState(message: 'An unknown error occurred. Please try again.'));
    }
  }
}
