import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../models/user/user.dart';
import '../../../data/repo/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo authRepo;

  SignupCubit(this.authRepo) : super(SignupInitial());

  Future<void> signupNewEmail({
    required String phoneNumber,
    required String email,
    required String password,
    required String userName,
    required Role role,
  }) async {
    emit(SignupLoadingState());
    var result = await authRepo.signupNewEmail(
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      userName: userName,
      role: role,
    );
    result.fold(
          (failure) => emit(SignupFailureState(message: failure.errMessage)),
          (successMessage) => emit(SignupSuccessState(message: successMessage)),
    );
  }
}
