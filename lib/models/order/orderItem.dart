import '../addon.dart';
import '../item.dart';

class OrderItem extends Item {
  final String userID;
  final String orderItemId;
  final int quantity;

  OrderItem({
    required this.orderItemId,
    required this.userID,
    required super.itemID,
    required super.itemName,
    required super.itemImageURL,
    required super.price,
    required super.des,
    super.addons,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderItemId: json["orderItemId"],
      userID:json['userID'],
      itemID: json["itemID"],
      itemName: json["itemName"],
      itemImageURL: json["itemImageURL"],
        des: json['des'],
      price: double.parse(json["price"].toString()), // Convert to string and then parse to double to handle numeric types
      quantity: int.parse(json["quantity"].toString()), // Convert to string and then parse to int to handle numeric types
      addons: json["addons"] != null ? (json["addons"] as List).map((i) => Addon.fromJson(i)).toList() : null, // Handle null and map addons if present
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data.addAll({
      "orderItemId": orderItemId,
      "quantity": quantity,
      "userID":userID
    });
    return data;
  }

  double get totalItemPrice {
    double addonsTotalPrice = 0;
    if (addons != null) {
      for (var addon in addons!) {
        addonsTotalPrice+=addon.addonPrice;
      }
    }
    return price * quantity + addonsTotalPrice;
  }
}