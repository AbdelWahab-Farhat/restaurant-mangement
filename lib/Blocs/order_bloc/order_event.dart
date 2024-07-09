part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}


class AddOrderItemEvent extends OrderEvent{
  final OrderItem orderItem;
  AddOrderItemEvent({required this.orderItem});
}
class RemoveOrderItemEvent extends OrderEvent{
  final OrderItem orderItem;
  RemoveOrderItemEvent({required this.orderItem});
}

class RemoveAllOrderItemsEvent extends OrderEvent {
  List<OrderItem> orderItems;
  RemoveAllOrderItemsEvent({required this.orderItems});
}
class LoadOrderItemsEvent extends OrderEvent {}