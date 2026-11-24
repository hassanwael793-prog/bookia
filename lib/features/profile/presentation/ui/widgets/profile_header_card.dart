import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/profile/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays the user's avatar, display name, email, and verification badge.
class ProfileHeaderCard extends StatelessWidget {
  final Data? profileData;

  const ProfileHeaderCard({
    super.key,
    required this.profileData,
  });

  @override
  Widget build(BuildContext context) {
    final name = _nonEmptyOrFallback(profileData?.name, 'Bookia Reader');
    final email = _nonEmptyOrFallback(profileData?.email, 'No email provided');
    final imageUrl = profileData?.image?.trim() ?? '';
    final isVerified = profileData?.emailVerified == true;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColor.witchColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _ProfileAvatar(
            imageUrl: imageUrl,
            displayName: name,
            isVerified: isVerified,
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DM',
                    color: AppColor.darkColor,
                  ),
                ),
                4.verticalSpace,
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.grayColor,
                  ),
                ),
                if (profileData?.emailVerified != null) ...[
                  10.verticalSpace,
                  _VerificationChip(isVerified: isVerified),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _nonEmptyOrFallback(String? value, String fallback) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return fallback;
    return trimmed;
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String displayName;
  final bool isVerified;

  const _ProfileAvatar({
    required this.imageUrl,
    required this.displayName,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 74.r,
          height: 74.r,
          padding: EdgeInsets.all(2.5.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.mainColor.withValues(alpha: 0.45),
              width: 1.5,
            ),
          ),
          child: ClipOval(
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        _AvatarFallback(displayName: displayName),
                  )
                : _AvatarFallback(displayName: displayName),
          ),
        ),
        if (isVerified)
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: Container(
              padding: EdgeInsets.all(3.r),
              decoration: const BoxDecoration(
                color: AppColor.witchColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.verified_rounded,
                size: 18.sp,
                color: AppColor.mainColor,
              ),
            ),
          ),
      ],
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  final String displayName;

  const _AvatarFallback({required this.displayName});

  @override
  Widget build(BuildContext context) {
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'B';
    return Container(
      color: AppColor.mainColor.withValues(alpha: 0.14),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'DM',
          color: AppColor.mainColor,
        ),
      ),
    );
  }
}

class _VerificationChip extends StatelessWidget {
  final bool isVerified;

  const _VerificationChip({required this.isVerified});

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isVerified ? const Color(0xffEAFAF1) : const Color(0xffFFF4E5);
    final fgColor =
        isVerified ? const Color(0xff27AE60) : const Color(0xffE67E22);
    final borderColor =
        isVerified ? const Color(0xffD5F5E3) : const Color(0xffFFE0B2);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor, width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVerified ? Icons.check_circle_rounded : Icons.info_outline_rounded,
            size: 13.sp,
            color: fgColor,
          ),
          5.horizontalSpace,
          Flexible(
            child: Text(
              isVerified ? 'Verified Account' : 'Email Not Verified',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: fgColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
