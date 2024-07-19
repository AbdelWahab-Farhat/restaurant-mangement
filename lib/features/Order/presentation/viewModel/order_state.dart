part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}
final class OrderLoading extends OrderState {}
final class OrderFailure extends OrderState {
  final String errMessage;
  OrderFailure({required this.errMessage});

}
final class OrderSuccess extends OrderState {
  final List<OrderItem> orderItems;
  OrderSuccess({required this.orderItems});
}


