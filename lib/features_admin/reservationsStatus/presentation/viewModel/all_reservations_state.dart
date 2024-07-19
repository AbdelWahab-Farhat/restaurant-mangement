part of 'all_reservations_cubit.dart';

@immutable
sealed class AllReservationsState {}

final class AllReservationsInitial extends AllReservationsState {}
final class AllReservationsLoading extends AllReservationsState {}
final class AllReservationsFailure extends AllReservationsState {
  final String errMessage;

  AllReservationsFailure({required this.errMessage});
}
final class AllReservationsSuccess extends AllReservationsState {
  final List<Customer> customers;

  AllReservationsSuccess({required this.customers});
}
