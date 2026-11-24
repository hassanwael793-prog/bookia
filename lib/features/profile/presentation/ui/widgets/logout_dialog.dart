import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/services/locale/locale_helper.dart';
import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/core/utils/app_const/app_Const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays a confirmation dialog before clearing the user session and
/// navigating back to the login screen.
class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const LogoutConfirmationDialog(),
    );
  }

  void _handleLogout(BuildContext context) {
    LocaleHelper.prefs?.remove(AppConst.userToken);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginScreen,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.witchColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: const Color(0xffFDEDEC),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xffFADBD8),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.logout_rounded,
                size: 28.sp,
                color: const Color(0xffE74C3C),
              ),
            ),
            16.verticalSpace,
            Text(
              'هل تريد تسجيل الخروج',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.darkColor,
              ),
            ),
            8.verticalSpace,
            Text(
              'You will need to sign in again to access your saved books and profile.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColor.grayColor,
                height: 1.45,
              ),
            ),
            22.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(0, 48.h),
                      side: const BorderSide(color: AppColor.borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkColor,
                      ),
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _handleLogout(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.mainColor,
                      foregroundColor: AppColor.witchColor,
                      elevation: 0,
                      minimumSize: Size(0, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.witchColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
