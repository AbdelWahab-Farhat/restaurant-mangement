import 'orderItem.dart';

class Order {
  String orderID;
  String customerID;
  OrderStatus orderStatus;
  DateTime orderDate;
  List<OrderItem> orderItems;
  double totalPrice;

  Order({
    required this.orderID,
    required this.customerID,
    required this.orderStatus,
    required this.orderDate,
    required this.orderItems,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderID: json["orderID"],
      customerID: json["customerID"],
      orderStatus: statusFromJson(json['orderStatus']),
      orderDate: DateTime.parse(json["orderDate"]),
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalPrice: (json["totalPrice"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderID": orderID,
      "customerID": customerID,
      "orderStatus": statusToJson(orderStatus),
      "orderDate": orderDate.toIso8601String(),
      "orderItems": orderItems.map((e) => e.toJson()).toList(),
      "totalPrice": totalPrice,
    };
  }
}

OrderStatus statusFromJson(String status) {
  switch (status) {
    case 'pending':
      return OrderStatus.pending;
    case 'ongoing':
      return OrderStatus.ongoing;
    case 'completed':
      return OrderStatus.completed;
    default:
      throw ArgumentError('Unknown order status: $status');
  }
}

String statusToJson(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'pending';
    case OrderStatus.ongoing:
      return 'ongoing';
    case OrderStatus.completed:
      return 'completed';
    default:
      throw ArgumentError('Unknown order status: $status');
  }
}

enum OrderStatus {
  pending,
  ongoing,
  completed,
}
