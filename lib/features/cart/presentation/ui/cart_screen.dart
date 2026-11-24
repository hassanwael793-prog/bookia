import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/cart/data/models/cart_responce.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/ui/widgets/cart_app_bar.dart';
import 'package:bookia/features/cart/presentation/ui/widgets/cart_empty_view.dart';
import 'package:bookia/features/cart/presentation/ui/widgets/cart_error_view.dart';
import 'package:bookia/features/cart/presentation/ui/widgets/cart_item_card.dart';
import 'package:bookia/features/cart/presentation/ui/widgets/cart_shimmer.dart';
import 'package:bookia/features/cart/presentation/ui/widgets/cart_summary_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is GetCartSuccess && state.actionError != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.actionError!),
                backgroundColor: const Color(0xffE74C3C),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        final cartData = state is GetCartSuccess ? state.cartData : null;
        final items = cartData?.cartItems ?? <CartItems>[];
        final hasItems = state is GetCartSuccess && items.isNotEmpty;

        return Scaffold(
          backgroundColor: AppColor.bgColor,
          bottomNavigationBar: hasItems && cartData != null
              ? CartSummaryBar(
                  cartData: cartData,
                  onCheckout: () => _handleCheckout(context),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                CartAppBar(itemCount: items.length),
                Expanded(
                  child: _CartBody(
                    state: state,
                    items: items,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleCheckout(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Checkout is coming soon'),
          backgroundColor: AppColor.darkColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
  }
}

class _CartBody extends StatelessWidget {
  final CartState state;
  final List<CartItems> items;

  const _CartBody({
    required this.state,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (state is GetCartLoading || state is CartInitial) {
      return const CartShimmer();
    }

    if (state is GetCartSuccess) {
      final successState = state as GetCartSuccess;
      final cubit = context.read<CartCubit>();

      if (items.isEmpty) {
        return RefreshIndicator(
          color: AppColor.mainColor,
          backgroundColor: AppColor.witchColor,
          onRefresh: () => cubit.getCartData(showLoading: false),
          child: CartEmptyView(
            onRefresh: () => cubit.getCartData(),
          ),
        );
      }

      return RefreshIndicator(
        color: AppColor.mainColor,
        backgroundColor: AppColor.witchColor,
        onRefresh: () => cubit.getCartData(showLoading: false),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          itemCount: items.length,
          separatorBuilder: (_, _) => 14.verticalSpace,
          itemBuilder: (context, index) {
            final item = items[index];
            final itemId = item.itemId;
            final currentQty = item.itemQuantity ?? 1;
            final isUpdating =
                itemId != null && successState.updatingItemId == itemId;

            return CartItemCard(
              item: item,
              isUpdating: isUpdating,
              onIncrement: () {
                if (itemId != null) {
                  cubit.updateItemQuantity(
                    cartItemId: itemId,
                    quantity: currentQty + 1,
                  );
                }
              },
              onDecrement: () {
                if (itemId != null && currentQty > 1) {
                  cubit.updateItemQuantity(
                    cartItemId: itemId,
                    quantity: currentQty - 1,
                  );
                }
              },
              onRemove: () {
                if (itemId != null) {
                  cubit.removeCartItem(cartItemId: itemId);
                }
              },
            );
          },
        ),
      );
    }

    return CartErrorView(
      onRetry: () => context.read<CartCubit>().getCartData(),
    );
  }
}
