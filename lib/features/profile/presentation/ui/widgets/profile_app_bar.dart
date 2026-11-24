import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/core/theam/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logout_dialog.dart';

/// Top header bar for the profile screen with a centered title and logout trigger.
class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

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
                'Profile',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle().font30regular.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.darkColor,
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Material(
                color: AppColor.witchColor,
                borderRadius: BorderRadius.circular(12.r),
                child: InkWell(
                  onTap: () => LogoutConfirmationDialog.show(context),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColor.borderColor),
                    ),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 20.sp,
                      color: AppColor.darkColor,
                    ),
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
