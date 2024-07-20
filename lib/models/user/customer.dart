import '../order/order.dart';
import '../reservation.dart';
import 'user.dart';

class Customer extends User {
  String customerID;
  String phoneNumber;
  List<Order>? orders;
  List<Reservation>? reservations;

  Customer({
    required super.userID,
    required super.userName,
    required super.password,
    required super.role,
    required this.customerID,
    required this.phoneNumber,
    this.orders,
    this.reservations,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      userID: json['userID'],
      userName: json['userName'],
      password: json['password'],
      role: roleFromJson(json['role']),
      customerID: json["customerID"],
      phoneNumber: json["phoneNumber"],
      orders: json['orders'] != null
          ? (json['orders'] as List)
              .map((order) => Order.fromJson(order))
              .toList()
          : null,
      reservations: json['reservations'] != null
          ? (json['reservations'] as List)
              .map((reservation) => Reservation.fromJson(reservation))
              .toList()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "userName": userName,
      "password": password,
      "role": roleToJson(role),
      "customerID": customerID,
      "phoneNumber": phoneNumber,
      "orders": orders?.map((order) => order.toJson()).toList(),
      "reservations":
          reservations?.map((reservation) => reservation.toJson()).toList(),
    };
  }
}
