import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/cart/data/models/cart_responce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Pinned bottom summary bar displaying total price and checkout action.
class CartSummaryBar extends StatelessWidget {
  final Data cartData;
  final VoidCallback onCheckout;

  const CartSummaryBar({
    super.key,
    required this.cartData,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final items = cartData.cartItems ?? [];
    final totalQuantity = items.fold<int>(
      0,
      (sum, item) => sum + (item.itemQuantity ?? 1),
    );
    final formattedTotal = _resolveFormattedTotal(cartData, items);

    return Container(
      decoration: BoxDecoration(
        color: AppColor.witchColor,
        border: const Border(
          top: BorderSide(color: AppColor.borderColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total ($totalQuantity ${totalQuantity == 1 ? 'book' : 'books'})',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGrayColor,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '\$$formattedTotal',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'DM',
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  foregroundColor: AppColor.witchColor,
                  minimumSize: Size(double.infinity, 52.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.witchColor,
                      ),
                    ),
                    8.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 19.sp,
                      color: AppColor.witchColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _resolveFormattedTotal(Data data, List<CartItems> items) {
    final parsedApiTotal = double.tryParse(data.total ?? '');
    if (parsedApiTotal != null) {
      return parsedApiTotal.toStringAsFixed(2);
    }

    final computed = items.fold<double>(
      0.0,
      (sum, item) => sum + (item.itemTotal ?? 0.0),
    );
    return computed.toStringAsFixed(2);
  }
}
