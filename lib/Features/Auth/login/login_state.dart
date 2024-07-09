part of 'login_cubit.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginErrorState extends LoginState {
  final String message;
  const LoginErrorState({required this.message});
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginSuccessState extends LoginState {
  final String message;
  const LoginSuccessState({required this.message});
}
