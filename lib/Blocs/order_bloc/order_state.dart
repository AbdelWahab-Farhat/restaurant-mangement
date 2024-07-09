part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {
  List<OrderItem> orderItems;
  OrderInitial({required this.orderItems});

}
final class OrderError extends OrderState {
  String massage;
  OrderError({required this.massage});
}
final class OrderLoading extends OrderState {}
final class OrderSuccess extends OrderState {
  List<OrderItem> orderItems;
  OrderSuccess({required this.orderItems});
}

