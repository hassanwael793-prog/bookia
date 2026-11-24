import 'package:bookia/features/cart/data/models/cart_responce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Data? _cachedCart;

  Future<void> getCartData({bool showLoading = true}) async {
    if (showLoading) {
      emit(GetCartLoading());
    }
    final response = await CartRepo.getCartData();

    if (response != null) {
      _cachedCart = response;
      emit(GetCartSuccess(response));
    } else {
      emit(GetCartError());
    }
  }

  Future<void> updateItemQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    if (quantity < 1) return;

    final previousCart = _cachedCart;
    if (previousCart != null) {
      emit(GetCartSuccess(previousCart, updatingItemId: cartItemId));
    }

    final updatedCart = await CartRepo.updateCartItem(
      cartItemId: cartItemId,
      quantity: quantity,
    );

    if (updatedCart != null) {
      _cachedCart = updatedCart;
      emit(GetCartSuccess(updatedCart));
    } else if (previousCart != null) {
      emit(
        GetCartSuccess(
          previousCart,
          actionError: 'Failed to update quantity. Please try again.',
        ),
      );
    } else {
      emit(GetCartError());
    }
  }

  Future<void> removeCartItem({required int cartItemId}) async {
    final previousCart = _cachedCart;
    if (previousCart != null) {
      emit(GetCartSuccess(previousCart, updatingItemId: cartItemId));
    }

    final updatedCart = await CartRepo.removeFromCart(cartItemId: cartItemId);

    if (updatedCart != null) {
      _cachedCart = updatedCart;
      emit(GetCartSuccess(updatedCart));
    } else if (previousCart != null) {
      emit(
        GetCartSuccess(
          previousCart,
          actionError: 'Failed to remove item. Please try again.',
        ),
      );
    } else {
      emit(GetCartError());
    }
  }
}
