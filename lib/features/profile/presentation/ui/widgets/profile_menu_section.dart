import 'package:bookia/core/theam/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays grouped account and support option tiles on the profile screen.
class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final options = <_MenuOptionData>[
      const _MenuOptionData(
        icon: Icons.shopping_bag_outlined,
        title: 'My Orders',
        subtitle: 'Track and review your book orders',
      ),
      const _MenuOptionData(
        icon: Icons.manage_accounts_outlined,
        title: 'Edit Profile',
        subtitle: 'Update your name, phone, and address',
      ),
      const _MenuOptionData(
        icon: Icons.lock_reset_rounded,
        title: 'Reset Password',
        subtitle: 'Manage your account security',
      ),
      const _MenuOptionData(
        icon: Icons.help_outline_rounded,
        title: 'FAQ',
        subtitle: 'Answers to common questions',
      ),
      const _MenuOptionData(
        icon: Icons.support_agent_rounded,
        title: 'Contact Us',
        subtitle: 'Get help from Bookia support',
      ),
      const _MenuOptionData(
        icon: Icons.privacy_tip_outlined,
        title: 'Privacy & Terms',
        subtitle: 'Review policies and terms of service',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 4.w),
          child: Text(
            'Preferences & Support',
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Column(
              children: [
                for (int i = 0; i < options.length; i++) ...[
                  ProfileOptionTile(
                    icon: options[i].icon,
                    title: options[i].title,
                    subtitle: options[i].subtitle,
                    onTap: () => _showComingSoon(context, options[i].title),
                  ),
                  if (i < options.length - 1)
                    const Divider(height: 1, color: AppColor.borderColor),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showComingSoon(BuildContext context, String featureTitle) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$featureTitle is coming soon'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColor.darkColor,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
  }
}

/// Reusable option row used inside profile menu sections.
class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
          child: Row(
            children: [
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColor.borderColor),
                ),
                child: Icon(
                  icon,
                  size: 19.sp,
                  color: AppColor.darkColor,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      2.verticalSpace,
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.grayColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              8.horizontalSpace,
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.sp,
                color: AppColor.grayColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuOptionData {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MenuOptionData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
