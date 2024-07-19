import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/features/auth/data/repo/auth_repo.dart';
import 'package:restaurant_management/models/user/user.dart' as u;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  u.User? currentUser;

  LoginCubit(this.authRepo) : super(const LoginInitial());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(const LoginLoadingState());
    var result = await authRepo.loginWithEmailAndPassword(email: email, password: password);
    result.fold((failure) => emit(LoginFailureState(message: failure.errMessage)),(user) {
      emit(const LoginSuccessState());
      currentUser = user;
    },);
  }
}
