

 import '../../models/addon.dart';
import '../../models/item.dart';
import '../../models/order/orderItem.dart';

// one item
double countItemFullPrice(Item item , int quantity ,List<Addon>? selectedAddon){
  double itemPrice = item.price;
  if (selectedAddon != null && selectedAddon.isNotEmpty) {
    for (var addon in selectedAddon){
      itemPrice+=addon.addonPrice;
    }
  }
  return itemPrice * quantity;
}
// ALL the items
 double totalItemsPrice(List<OrderItem> items) {
   double tp = 0;
   for (var item in items) {
     tp+= countItemFullPrice(item, item.quantity, item.addons);
   }
   return tp;
 }
