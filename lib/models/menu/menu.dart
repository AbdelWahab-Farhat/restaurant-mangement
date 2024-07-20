
import '../item.dart';

class Menu {
  String menuID;
  String menuName;
  List<Item>? menuItems;

  Menu({required this.menuID, required this.menuName, this.menuItems});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuID: json["menuID"],
      menuName: json["menuName"],
      menuItems: json['items'] != null
          ? (json['items'] as List).map((item) => Item.fromJson(item)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "menuID": menuID,
      "menuName": menuName,
      "items": menuItems?.map((item) => item.toJson()).toList(),
    };
  }

  int get numberOfItems => menuItems?.length ?? 0;
}
