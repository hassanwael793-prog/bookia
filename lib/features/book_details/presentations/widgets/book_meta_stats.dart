import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theam/app_color.dart';
import '../../data/model/book_details_model.dart';

class BookMetaStats extends StatelessWidget {
  final Data? book;

  const BookMetaStats({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final stockCount = book?.stock ?? 10;
    final isAvailable = stockCount > 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Rating Item
          _StatTile(
            icon: Icons.star_rounded,
            iconColor: const Color(0xffF1C40F),
            iconBgColor: const Color(0xffFFF9E6),
            title: '4.8',
            subtitle: 'Rating',
          ),
          _VerticalDivider(),

          // Page Count Item
          _StatTile(
            icon: Icons.auto_stories_rounded,
            iconColor: const Color(0xff3498DB),
            iconBgColor: const Color(0xffEBF5FB),
            title: '320',
            subtitle: 'Pages',
          ),
          _VerticalDivider(),

          // Language Item
          _StatTile(
            icon: Icons.language_rounded,
            iconColor: const Color(0xff9B59B6),
            iconBgColor: const Color(0xffF5EEF8),
            title: 'English',
            subtitle: 'Language',
          ),
          _VerticalDivider(),

          // Stock / Availability Item
          _StatTile(
            icon: isAvailable ? Icons.inventory_2_outlined : Icons.remove_shopping_cart_outlined,
            iconColor: isAvailable ? const Color(0xff27AE60) : const Color(0xffE74C3C),
            iconBgColor: isAvailable ? const Color(0xffEAFAF1) : const Color(0xffFDEDEC),
            title: isAvailable ? '$stockCount left' : 'Out of Stock',
            subtitle: 'Availability',
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;

  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: iconColor,
          ),
        ),
        8.verticalSpace,
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.darkColor,
          ),
        ),
        2.verticalSpace,
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.grayColor,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36.h,
      color: AppColor.borderColor,
    );
  }
}
