part of 'reservation_bloc.dart';

@immutable
sealed class ReservationEvent {}


class AddReservationEvent extends ReservationEvent {
  Reservation reservation;
  AddReservationEvent({required this.reservation});
}
class CancelReservationEvent extends ReservationEvent{
  Reservation reservation;
  CancelReservationEvent({required this.reservation});
}

class LoadReservationEvent extends ReservationEvent {}
