part of 'reservation_cubit.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}
final class ReservationLoading extends ReservationState {}
final class ReservationFailure extends ReservationState {
  final String errMessage;

  ReservationFailure({required this.errMessage});

}
final class ReservationSuccess extends ReservationState {
  final Customer  customer;

  ReservationSuccess({required this.customer});
}
