import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theam/app_color.dart';
import '../../data/model/book_details_model.dart';

class BookBottomActionBar extends StatelessWidget {
  final Data? book;
  final VoidCallback? onBuyNowPressed;
  final VoidCallback? onPreviewPressed;

  const BookBottomActionBar({
    super.key,
    required this.book,
    this.onBuyNowPressed,
    this.onPreviewPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = (book?.discount != null && book!.discount! > 0);
    final finalPrice = hasDiscount
        ? (book?.priceAfterDiscount?.toStringAsFixed(2) ?? book?.price ?? '0.00')
        : (book?.price ?? '0.00');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: AppColor.borderColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              // Secondary CTA: Preview / Sample Button
              _SecondaryActionButton(
                icon: Icons.menu_book_outlined,
                label: 'Preview',
                onPressed: () {
                  if (onPreviewPressed != null) {
                    onPreviewPressed!();
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.menu_book_rounded, color: Colors.white, size: 20.sp),
                            SizedBox(width: 10.w),
                            const Text('Opening book preview sample...'),
                          ],
                        ),
                        backgroundColor: AppColor.darkColor,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),

              12.horizontalSpace,

              // Primary CTA: Buy Now Button
              Expanded(
                child: _PrimaryBuyButton(
                  price: finalPrice,
                  onPressed: () {
                    if (onBuyNowPressed != null) {
                      onBuyNowPressed!();
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20.sp),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  'Added "${book?.name ?? 'Book'}" to cart (\$ $finalPrice)',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: AppColor.mainColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SecondaryActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.darkColor,
        side: const BorderSide(color: AppColor.borderColor, width: 1.2),
        minimumSize: Size(110.w, 52.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.sp, color: AppColor.darkColor),
          6.horizontalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.darkColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryBuyButton extends StatelessWidget {
  final String price;
  final VoidCallback onPressed;

  const _PrimaryBuyButton({
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.mainColor,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 52.h),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 20.sp, color: Colors.white),
          8.horizontalSpace,
          Text(
            'Buy Now',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
          8.horizontalSpace,
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.circle,
            ),
          ),
          8.horizontalSpace,
          Text(
            '\$$price',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
