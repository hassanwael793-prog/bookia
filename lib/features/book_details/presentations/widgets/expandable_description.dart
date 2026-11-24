import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theam/app_color.dart';

class ExpandableDescription extends StatefulWidget {
  final String? description;

  const ExpandableDescription({
    super.key,
    required this.description,
  });

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = (widget.description != null && widget.description!.trim().isNotEmpty)
        ? widget.description!.trim()
        : 'No description available for this book.';

    // Approximate threshold to show Read More button if text is long enough
    final isLongText = text.length > 160;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Accent Bar
        Row(
          children: [
            Container(
              width: 3.5.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            8.horizontalSpace,
            Text(
              'About the Book',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'DM',
                color: AppColor.darkColor,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),

        12.verticalSpace,

        // Animated Description Body
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: Text(
            text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.darkGrayColor,
              height: 1.65,
            ),
          ),
          secondChild: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.darkGrayColor,
              height: 1.65,
            ),
          ),
        ),

        // Read More / Read Less Toggle
        if (isLongText) ...[
          6.verticalSpace,
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(6.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? 'Read Less' : 'Read More',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mainColor,
                    ),
                  ),
                  4.horizontalSpace,
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColor.mainColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
