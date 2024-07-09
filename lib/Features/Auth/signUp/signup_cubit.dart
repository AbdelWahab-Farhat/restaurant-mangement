import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_management/models/user/user.dart' as account;
import 'package:uuid/uuid.dart';

import '../../../models/user/customer.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  SignupCubit(this.firestore, this.firebaseAuth) : super(SignupInitial());

  Future<void> signupNewEmail(String phoneNumber, String email, String password,
      String userName, account.Role role) async {
    emit(SignupLoadingState());
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? authUser = userCredential.user;

      if (authUser != null) {
        final appUser = Customer(
          userID: authUser.uid,
          customerID: const Uuid().v4(),
          phoneNumber: phoneNumber,
          userName: userName,
          password: password,
          role: role,
        );
        await firestore
            .collection('users')
            .doc(authUser.uid)
            .set(appUser.toJson());
        await authUser.sendEmailVerification();
        emit(SignupSuccessState(
            message: 'Sign-up successful. Please verify your email.'));
      } else {
        emit(SignupErrorState(message: 'Sign-up failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(SignupErrorState(message: 'Sign-up failed: ${e.message}'));
    } catch (e) {
      emit(SignupErrorState(message: 'An unknown error occurred.'));
    }
  }
}
