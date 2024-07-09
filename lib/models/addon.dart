



class Addon {
  String addonName;
  double addonPrice;

  Addon({
    required this.addonName,
    required this.addonPrice,
  });

  // Factory method to create an Addon object from a JSON map
  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
        addonName: json["addonName"],
        addonPrice: (json["addonPrice"] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {
      "addonName": addonName,
      "addonPrice": addonPrice,
    };
  }
}
