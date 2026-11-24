import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/cart/data/models/cart_responce.dart';

class CartRepo {
  static Future<Data?> getCartData() async {
    try {
      final response = await DioFactory.dio?.get("cart");
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        final payload = response?.data;
        if (payload is Map<String, dynamic>) {
          final cart = CartResponse.fromJson(payload);
          return cart.data ?? Data(cartItems: []);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Data?> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        "update-cart",
        data: {
          "cart_item_id": cartItemId,
          "quantity": quantity,
        },
      );
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        final payload = response?.data;
        if (payload is Map<String, dynamic>) {
          final cart = CartResponse.fromJson(payload);
          return cart.data ?? Data(cartItems: []);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Data?> removeFromCart({
    required int cartItemId,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        "remove-from-cart",
        data: {
          "cart_item_id": cartItemId,
        },
      );
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        final payload = response?.data;
        if (payload is Map<String, dynamic>) {
          final cart = CartResponse.fromJson(payload);
          return cart.data ?? Data(cartItems: []);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
