import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';

import '../../../../models/user/customer.dart';
import '../../../../models/user/user.dart' as us;
import '../../../../utility/errors/failure.dart';
import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore store;
  AuthRepoImpl({required this.auth, required this.store});
  @override
  Future<Either<Failure, us.User>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null && user.emailVerified) {
        // TODO: CHANGE IT LATER
        final documentSnapshot =
            await store.collection('users').doc(user.uid).get();
        us.User userRes = us.User.fromJson(documentSnapshot.data()!);
        return right(userRes);
      } else if (user != null && !user.emailVerified) {
        return left(FailureService(
            errMessage: 'Please Verify your Email Before Login in'));
      } else {
        return left(
            FailureService(errMessage: 'Opps,Some Error Happened From Server'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          return left(FailureService(errMessage: errorMessage));
        case 'user-disabled':
          errorMessage =
              'The user corresponding to the given email has been disabled.';
          return left(FailureService(errMessage: errorMessage));
        case 'user-not-found':
          errorMessage = 'There is no user corresponding to the given email.';
          return left(FailureService(errMessage: errorMessage));
        case 'wrong-password':
          errorMessage = 'The password is invalid for the given email.';
          return left(FailureService(errMessage: errorMessage));
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
          return left(FailureService(errMessage: errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, String>> signupNewEmail({
    required String phoneNumber,
    required String email,
    required String password,
    required String userName,
    required us.Role role,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
        await store.collection('users').doc(authUser.uid).set(appUser.toJson());
        await authUser.sendEmailVerification();
        return right('Sign up completed, please check your email to verify.');
      } else {
        return left(FailureService(errMessage: 'Sign-up failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      return left(FailureService(errMessage: e.message ?? 'Unknown error occurred.'));
    } catch (e) {
      return left(FailureService(errMessage: 'Sign-up failed. Please try again.'));
    }
  }
  }
