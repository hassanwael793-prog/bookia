import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theam/app_color.dart';
import '../../data/model/book_details_model.dart';

class BookHeaderInfo extends StatelessWidget {
  final Data? book;

  const BookHeaderInfo({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final title = (book?.name != null && book!.name!.isNotEmpty)
        ? book!.name!
        : 'Book Title';

    final category = (book?.category != null && book!.category!.isNotEmpty)
        ? book!.category!
        : 'General';

    final hasDiscount = (book?.discount != null && book!.discount! > 0);
    final isBestSeller = (book?.bestSeller == 1);

    final displayPrice = hasDiscount
        ? (book?.priceAfterDiscount?.toStringAsFixed(2) ?? book?.price ?? '0.00')
        : (book?.price ?? '0.00');

    final originalPrice = book?.price ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badges & Tag Chips Row
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            // Category Chip
            _BadgeChip(
              text: category,
              icon: Icons.category_outlined,
              backgroundColor: AppColor.mainColor.withOpacity(0.12),
              textColor: AppColor.mainColor,
              borderColor: AppColor.mainColor.withOpacity(0.24),
            ),

            // Best Seller Badge
            if (isBestSeller)
              _BadgeChip(
                text: 'Best Seller',
                icon: Icons.local_fire_department_rounded,
                backgroundColor: const Color(0xffFFF4E5),
                textColor: const Color(0xffE67E22),
                borderColor: const Color(0xffFFE0B2),
              ),

            // Discount Badge
            if (hasDiscount)
              _BadgeChip(
                text: '-${book!.discount}% OFF',
                icon: Icons.discount_outlined,
                backgroundColor: const Color(0xffFDE8E8),
                textColor: const Color(0xffE53E3E),
                borderColor: const Color(0xffFED7D7),
              ),
          ],
        ),

        14.verticalSpace,

        // Book Title
        Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'DM',
            color: AppColor.darkColor,
            height: 1.25,
            letterSpacing: -0.3,
          ),
        ),

        8.verticalSpace,

        // Author / Publisher Subtitle
        Row(
          children: [
            Text(
              'By ',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.grayColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Bookia Publications',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.darkGrayColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.horizontalSpace,
            Icon(
              Icons.verified_rounded,
              color: AppColor.mainColor,
              size: 16.sp,
            ),
          ],
        ),

        16.verticalSpace,

        // Pricing Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '\$$displayPrice',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: AppColor.mainColor,
                letterSpacing: -0.5,
              ),
            ),
            if (hasDiscount && originalPrice.isNotEmpty) ...[
              10.horizontalSpace,
              Text(
                '\$$originalPrice',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grayColor,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColor.grayColor,
                ),
              ),
              8.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xffEBF8F2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Save ${book!.discount}%',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff27AE60),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const _BadgeChip({
    required this.text,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor, width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13.sp, color: textColor),
            4.horizontalSpace,
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
