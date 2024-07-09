part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupErrorState extends SignupState {
  String message;
  SignupErrorState({required this.message});
}
final class SignupSuccessState extends SignupState {
  String message;
  SignupSuccessState({required this.message});
}
final class SignupLoadingState extends SignupState {}

