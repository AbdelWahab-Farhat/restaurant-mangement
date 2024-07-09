part of 'reservation_bloc.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}
final class ReservationSuccess extends ReservationState {
  List<Reservation> reservations;
  Customer customer;
  ReservationSuccess({required this.reservations, required this.customer});
}
final class ReservationError extends ReservationState {
  String massage;
  ReservationError({required this.massage});
}
final class ReservationLoading extends ReservationState {}



