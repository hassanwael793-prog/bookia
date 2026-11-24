import 'package:bookia/core/theam/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Error state view for the profile screen with a retry action.
class ProfileErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const ProfileErrorView({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84.r,
              height: 84.r,
              decoration: BoxDecoration(
                color: const Color(0xffFDEDEC),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xffFADBD8),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 40.sp,
                color: const Color(0xffE74C3C),
              ),
            ),
            20.verticalSpace,
            Text(
              'Failed to load profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'DM',
                color: AppColor.darkColor,
              ),
            ),
            8.verticalSpace,
            Text(
              'We could not retrieve your account information. Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.darkGrayColor,
                height: 1.5,
              ),
            ),
            24.verticalSpace,
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, color: AppColor.witchColor),
              label: Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.witchColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainColor,
                minimumSize: Size(160.w, 48.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
