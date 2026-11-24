import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theam/app_color.dart';

class BookDetailsErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const BookDetailsErrorView({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.darkColor),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90.r,
                height: 90.r,
                decoration: BoxDecoration(
                  color: const Color(0xffFDEDEC),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xffFADBD8), width: 2),
                ),
                child: Icon(
                  Icons.cloud_off_rounded,
                  size: 44.sp,
                  color: const Color(0xffE74C3C),
                ),
              ),

              24.verticalSpace,

              Text(
                'Failed to load book',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DM',
                  color: AppColor.darkColor,
                ),
              ),

              8.verticalSpace,

              Text(
                'Something went wrong while fetching the book details. Please check your internet connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.darkGrayColor,
                  height: 1.5,
                ),
              ),

              28.verticalSpace,

              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                label: Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  minimumSize: Size(160.w, 48.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
