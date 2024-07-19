part of 'login_cubit.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginFailureState extends LoginState {
  final String message;
  const LoginFailureState({required this.message});
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}
