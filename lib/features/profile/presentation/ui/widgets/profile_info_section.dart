import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/profile/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays structured personal contact and address fields from [Data].
class ProfileInfoSection extends StatelessWidget {
  final Data? profileData;

  const ProfileInfoSection({
    super.key,
    required this.profileData,
  });

  @override
  Widget build(BuildContext context) {
    final phone = _formatValue(profileData?.phone?.toString());
    final city = _formatValue(profileData?.city);
    final address = _formatValue(profileData?.address);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 4.w),
          child: Text(
            'Account Information',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'DM',
              color: AppColor.darkColor,
            ),
          ),
        ),
        10.verticalSpace,
        Container(
          decoration: BoxDecoration(
            color: AppColor.witchColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColor.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _ProfileInfoTile(
                icon: Icons.phone_outlined,
                label: 'Phone Number',
                value: phone,
              ),
              const Divider(height: 1, color: AppColor.borderColor),
              _ProfileInfoTile(
                icon: Icons.location_city_outlined,
                label: 'City',
                value: city,
              ),
              const Divider(height: 1, color: AppColor.borderColor),
              _ProfileInfoTile(
                icon: Icons.location_on_outlined,
                label: 'Address',
                value: address,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? _formatValue(String? raw) {
    final trimmed = raw?.trim();
    if (trimmed == null || trimmed.isEmpty || trimmed == 'null') {
      return null;
    }
    return trimmed;
  }
}

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const _ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
      child: Row(
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 19.sp,
              color: AppColor.mainColor,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.grayColor,
                  ),
                ),
                3.verticalSpace,
                Text(
                  value ?? 'Not provided',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: hasValue ? FontWeight.w600 : FontWeight.w400,
                    color: hasValue ? AppColor.darkColor : AppColor.grayColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
