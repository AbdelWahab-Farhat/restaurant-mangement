part of 'order_history_cubit.dart';

@immutable
sealed class OrderHistoryState {}

final class OrderHistoryInitial extends OrderHistoryState {}
final class OrderHistoryLoading extends OrderHistoryState {}
final class OrderHistoryError extends OrderHistoryState{
  String message;
  OrderHistoryError({required this.message});
}
final class OrderHistorySuccess extends OrderHistoryState {
  List<Order> userOrders;
  OrderHistorySuccess({required this.userOrders});
}
