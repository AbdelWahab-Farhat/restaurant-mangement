part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileError extends ProfileState {
  String message;

  ProfileError({required this.message});
}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  Customer customer;
  ProfileSuccess({required this.customer});
}
