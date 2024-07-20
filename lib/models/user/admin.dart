
import '../order/order.dart';
import 'user.dart';

class Admin extends User {
  String adminID;
  String phoneNumber;
  List<Order>? orders;
  double salary;

  Admin(
      {required super.userID,
      required super.userName,
      required super.password,
      required super.role,
      required this.adminID,
      required this.phoneNumber,
      this.orders,
      required this.salary});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      userID: json['userID'],
      userName: json['userName'],
      password: json['password'],
      phoneNumber: json["phoneNumber"],
      role: json['role'],
      adminID: json["adminID"],
      salary: double.parse(json["salary"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "adminID": adminID,
      "phoneNumber": phoneNumber,
      "orders": orders?.map((order) => order.toJson()),
      "salary": salary,
    };
  }
}
