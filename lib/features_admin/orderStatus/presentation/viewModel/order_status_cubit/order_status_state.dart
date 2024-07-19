part of 'order_status_cubit.dart';

@immutable
sealed class OrderStatusState {}

final class OrderStatusInitial extends OrderStatusState {}
final class OrderStatusLoading extends OrderStatusState {}
final class OrderStatusFailure extends OrderStatusState {
  final String errMessage;

  OrderStatusFailure({required this.errMessage});
}
final class OrderStatusSuccess extends OrderStatusState {
  final List<Order> orders;
  OrderStatusSuccess({required this.orders});
}

