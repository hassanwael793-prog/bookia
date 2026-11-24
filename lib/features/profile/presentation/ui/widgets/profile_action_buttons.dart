import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logout_dialog.dart';

/// Primary bottom action section for signing out of the current session.
class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => LogoutConfirmationDialog.show(context),
        icon: Icon(
          Icons.logout_rounded,
          size: 19.sp,
          color: const Color(0xffE74C3C),
        ),
        label: Text(
          'Log Out',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffE74C3C),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xffFDEDEC).withValues(alpha: 0.55),
          minimumSize: Size(double.infinity, 52.h),
          side: const BorderSide(color: Color(0xffFADBD8)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      ),
    );
  }
}
