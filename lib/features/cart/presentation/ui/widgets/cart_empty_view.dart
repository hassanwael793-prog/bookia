import 'package:bookia/core/theam/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Empty state view displayed when the cart contains no items.
class CartEmptyView extends StatelessWidget {
  final VoidCallback onRefresh;

  const CartEmptyView({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 92.r,
                      height: 92.r,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.mainColor.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 42.sp,
                        color: AppColor.mainColor,
                      ),
                    ),
                    20.verticalSpace,
                    Text(
                      'Your cart is empty',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DM',
                        color: AppColor.darkColor,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      'Looks like you have not added any books yet. Explore our best sellers and add your next read.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.darkGrayColor,
                        height: 1.5,
                      ),
                    ),
                    24.verticalSpace,
                    ElevatedButton.icon(
                      onPressed: onRefresh,
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: AppColor.witchColor,
                      ),
                      label: Text(
                        'Refresh Cart',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.witchColor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        minimumSize: Size(170.w, 48.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
