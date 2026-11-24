class CartResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CartResponse({this.data, this.message, this.error, this.status});

  CartResponse.fromJson(Map<String, dynamic> json) {
    data = json["data"] is Map<String, dynamic>
        ? Data.fromJson(json["data"] as Map<String, dynamic>)
        : null;
    message = json["message"]?.toString();
    error = json["error"] is List ? json["error"] as List<dynamic> : [];
    status = (json["status"] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    if (data != null) {
      dataMap["data"] = data?.toJson();
    }
    dataMap["message"] = message;
    if (error != null) {
      dataMap["error"] = error;
    }
    dataMap["status"] = status;
    return dataMap;
  }
}

class Data {
  int? id;
  User? user;
  String? total;
  List<CartItems>? cartItems;

  Data({this.id, this.user, this.total, this.cartItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = (json["id"] as num?)?.toInt();
    user = json["user"] is Map<String, dynamic>
        ? User.fromJson(json["user"] as Map<String, dynamic>)
        : null;
    total = json["total"]?.toString();
    cartItems = json["cart_items"] is List
        ? (json["cart_items"] as List)
            .whereType<Map<String, dynamic>>()
            .map(CartItems.fromJson)
            .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap["id"] = id;
    if (user != null) {
      dataMap["user"] = user?.toJson();
    }
    dataMap["total"] = total;
    if (cartItems != null) {
      dataMap["cart_items"] = cartItems?.map((e) => e.toJson()).toList();
    }
    return dataMap;
  }
}

class CartItems {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItems({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  CartItems.fromJson(Map<String, dynamic> json) {
    itemId = (json["item_id"] as num?)?.toInt();
    itemProductId = (json["item_product_id"] as num?)?.toInt();
    itemProductName = json["item_product_name"]?.toString();
    itemProductImage = json["item_product_image"]?.toString();
    itemProductPrice = json["item_product_price"]?.toString();
    itemProductDiscount = (json["item_product_discount"] as num?)?.toInt();
    itemProductPriceAfterDiscount =
        (json["item_product_price_after_discount"] as num?)?.toDouble();
    itemProductStock = (json["item_product_stock"] as num?)?.toInt();
    itemQuantity = (json["item_quantity"] as num?)?.toInt();
    itemTotal = (json["item_total"] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap["item_id"] = itemId;
    dataMap["item_product_id"] = itemProductId;
    dataMap["item_product_name"] = itemProductName;
    dataMap["item_product_image"] = itemProductImage;
    dataMap["item_product_price"] = itemProductPrice;
    dataMap["item_product_discount"] = itemProductDiscount;
    dataMap["item_product_price_after_discount"] =
        itemProductPriceAfterDiscount;
    dataMap["item_product_stock"] = itemProductStock;
    dataMap["item_quantity"] = itemQuantity;
    dataMap["item_total"] = itemTotal;
    return dataMap;
  }
}

class User {
  int? userId;
  String? userName;

  User({this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    userId = (json["user_id"] as num?)?.toInt();
    userName = json["user_name"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap["user_id"] = userId;
    dataMap["user_name"] = userName;
    return dataMap;
  }
}
