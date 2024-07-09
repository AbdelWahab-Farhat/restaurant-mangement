import 'addon.dart';

class Item {
  final String itemID;
  final String itemName;
  final String itemImageURL;
  final double price;
  final String des;
  List<Addon>? addons;

  Item({
    required this.itemID,
    required this.itemName,
    required this.itemImageURL,
    required this.price,
  required this.des,
    this.addons,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      des:json['des'],
      itemID: json["itemID"],
      itemName: json["itemName"],
      itemImageURL: json['itemImageURL'],
      price: double.parse(json["price"].toString()),
      // Convert to string and then parse to double to handle numeric types
      addons: json["addons"] != null
          ? (json["addons"] as List).map((i) => Addon.fromJson(i)).toList()
          : null, // Handle null and map addons if present
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "itemID": itemID,
      "itemName": itemName,
      "itemImageURL": itemImageURL,
      "des":des,
      "price": price,
      "addons": addons?.map((addon) => addon.toJson()).toList(),
    };
  }
}
