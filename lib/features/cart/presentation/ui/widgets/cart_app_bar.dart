import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/core/theam/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Top header bar for the cart screen showing the title and active item count.
class CartAppBar extends StatelessWidget {
  final int itemCount;

  const CartAppBar({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: SizedBox(
        height: 44.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                'My Cart',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle().font30regular.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.darkColor,
                    ),
              ),
            ),
            if (itemCount > 0)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColor.mainColor.withValues(alpha: 0.28),
                    ),
                  ),
                  child: Text(
                    '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
