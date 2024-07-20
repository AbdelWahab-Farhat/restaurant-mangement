import 'package:day_night_time_picker/lib/state/time.dart';

import 'order/order.dart';

class Reservation {
  String reservationID;
  String customerID;
  String orderID;
  int tableNumber;
  DateTime reservationDate;
  Time time; // Assuming Time is from day_night_time_picker library

  Reservation({
    required this.reservationID,
    required this.customerID,
    required this.orderID,
    required this.tableNumber,
    required this.time,
    required this.reservationDate,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationID: json["reservationID"],
      customerID: json["customerID"],
      orderID: json["orderID"],
      tableNumber: (json['tableNumber'] as num).toInt(),
      reservationDate: DateTime.parse(json["reservationDate"]),
      time: Time(
        hour: json['time']['hour'],
        minute: json['time']['minute'],
      ),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "reservationID": reservationID,
      "customerID": customerID,
      "orderID": orderID,
      "tableNumber": tableNumber,
      "reservationDate": reservationDate.toIso8601String(),
      "time": {
        "hour": time.hour,
        "minute": time.minute,
      },
    };
  }

  Order? reservationOrder(List<Order> orders) {
    for (var order in orders) {
      if (orderID == order.orderID) {
        return order;
      }
    }
    return null;
  }
}
