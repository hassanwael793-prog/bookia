import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/cart/data/models/cart_responce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays a single book item inside the shopping cart with quantity and
/// removal controls.
class CartItemCard extends StatelessWidget {
  final CartItems item;
  final bool isUpdating;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.isUpdating,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final title = (item.itemProductName?.trim().isNotEmpty ?? false)
        ? item.itemProductName!.trim()
        : 'Book';
    final imageUrl = item.itemProductImage?.trim() ?? '';
    final quantity = item.itemQuantity ?? 1;
    final stock = item.itemProductStock;
    final discount = item.itemProductDiscount ?? 0;
    final hasDiscount = discount > 0;

    final rawOriginalPrice =
        double.tryParse(item.itemProductPrice ?? '') ?? 0.0;
    final unitPrice = item.itemProductPriceAfterDiscount ?? rawOriginalPrice;
    final lineTotal = item.itemTotal ?? (unitPrice * quantity);

    final canDecrement = !isUpdating && quantity > 1;
    final canIncrement = !isUpdating && (stock == null || quantity < stock);
    final isLowStock = stock != null && stock > 0 && stock <= 5;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColor.witchColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BookThumbnail(
            imageUrl: imageUrl,
            discount: discount,
            hasDiscount: hasDiscount,
            onTap: () => _openBookDetails(context),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _openBookDetails(context),
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM',
                            color: AppColor.darkColor,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    _RemoveButton(
                      isUpdating: isUpdating,
                      onTap: onRemove,
                    ),
                  ],
                ),
                6.verticalSpace,
                Wrap(
                  spacing: 8.w,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '\$${unitPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.mainColor,
                      ),
                    ),
                    if (hasDiscount && rawOriginalPrice > 0)
                      Text(
                        '\$${rawOriginalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.grayColor,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColor.grayColor,
                        ),
                      ),
                  ],
                ),
                if (isLowStock) ...[
                  5.verticalSpace,
                  Text(
                    'Only $stock left in stock',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffE67E22),
                    ),
                  ),
                ],
                12.verticalSpace,
                Row(
                  children: [
                    _QuantityStepper(
                      quantity: quantity,
                      isUpdating: isUpdating,
                      canDecrement: canDecrement,
                      canIncrement: canIncrement,
                      onDecrement: onDecrement,
                      onIncrement: onIncrement,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColor.grayColor,
                            ),
                          ),
                          Text(
                            '\$${lineTotal.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openBookDetails(BuildContext context) {
    final productId = item.itemProductId;
    if (productId == null) return;
    Navigator.pushNamed(
      context,
      AppRoutes.bookDetailsScreen,
      arguments: productId,
    );
  }
}

class _BookThumbnail extends StatelessWidget {
  final String imageUrl;
  final int discount;
  final bool hasDiscount;
  final VoidCallback onTap;

  const _BookThumbnail({
    required this.imageUrl,
    required this.discount,
    required this.hasDiscount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 82.w,
              height: 110.h,
              color: AppColor.bgColor,
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const _ImagePlaceholder(),
                    )
                  : const _ImagePlaceholder(),
            ),
          ),
          if (hasDiscount)
            PositionedDirectional(
              top: 6.h,
              start: 6.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xffE53E3E),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '-$discount%',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.witchColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.menu_book_rounded,
        size: 30.sp,
        color: AppColor.grayColor,
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  final bool isUpdating;
  final VoidCallback onTap;

  const _RemoveButton({
    required this.isUpdating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffFDEDEC).withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: isUpdating ? null : onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(6.r),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 18.sp,
            color: isUpdating
                ? AppColor.grayColor
                : const Color(0xffE74C3C),
          ),
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final int quantity;
  final bool isUpdating;
  final bool canDecrement;
  final bool canIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _QuantityStepper({
    required this.quantity,
    required this.isUpdating,
    required this.canDecrement,
    required this.canIncrement,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: Icons.remove_rounded,
            enabled: canDecrement,
            onTap: onDecrement,
          ),
          SizedBox(
            width: 34.w,
            child: Center(
              child: isUpdating
                  ? SizedBox(
                      width: 14.r,
                      height: 14.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor.mainColor,
                      ),
                    )
                  : Text(
                      '$quantity',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.darkColor,
                      ),
                    ),
            ),
          ),
          _StepperButton(
            icon: Icons.add_rounded,
            enabled: canIncrement,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _StepperButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8.r),
      child: SizedBox(
        width: 32.r,
        height: 32.r,
        child: Icon(
          icon,
          size: 16.sp,
          color: enabled ? AppColor.darkColor : AppColor.grayColor,
        ),
      ),
    );
  }
}
