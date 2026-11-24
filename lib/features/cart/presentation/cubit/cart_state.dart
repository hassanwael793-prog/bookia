part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartLoading extends CartState {}

final class GetCartSuccess extends CartState {
  final Data? cartData;
  final int? updatingItemId;
  final String? actionError;

  GetCartSuccess(
    this.cartData, {
    this.updatingItemId,
    this.actionError,
  });
}

final class GetCartError extends CartState {}
