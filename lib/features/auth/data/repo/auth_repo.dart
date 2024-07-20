import 'package:dartz/dartz.dart';

import '../../../../models/user/user.dart';
import '../../../../utility/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> loginWithEmailAndPassword({required String email, required String password});

  Future<Either<Failure, String>> signupNewEmail(
      {required String phoneNumber,
      required String email,
      required String password,
      required String userName,
      required Role role});
}
