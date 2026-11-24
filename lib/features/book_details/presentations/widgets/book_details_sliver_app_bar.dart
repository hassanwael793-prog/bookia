import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theam/app_color.dart';
import '../../data/model/book_details_model.dart';

class BookDetailsSliverAppBar extends StatefulWidget {
  final Data? book;

  const BookDetailsSliverAppBar({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailsSliverAppBar> createState() => _BookDetailsSliverAppBarState();
}

class _BookDetailsSliverAppBarState extends State<BookDetailsSliverAppBar> {
  bool _isBookmarked = false;

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isBookmarked ? Icons.bookmark_added_rounded : Icons.bookmark_remove_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              _isBookmarked ? 'Added to your wishlist' : 'Removed from your wishlist',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: AppColor.darkColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onSharePressed() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.share_rounded, color: Colors.white, size: 20.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                'Sharing "${widget.book?.name ?? 'Book'}"...',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: AppColor.mainColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.book?.image ?? '';
    final heroTag = 'book_cover_${widget.book?.id ?? widget.book?.name ?? 'default'}';

    return SliverAppBar(
      expandedHeight: 380.h,
      pinned: true,
      stretch: true,
      backgroundColor: AppColor.bgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 64.w,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, top: 6.h, bottom: 6.h),
        child: _GlassIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          iconSize: 18.sp,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      actions: [
        _GlassIconButton(
          icon: _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          iconColor: _isBookmarked ? AppColor.mainColor : AppColor.darkColor,
          iconSize: 20.sp,
          onPressed: _toggleBookmark,
        ),
        SizedBox(width: 10.w),
        _GlassIconButton(
          icon: Icons.share_outlined,
          iconSize: 20.sp,
          onPressed: _onSharePressed,
        ),
        SizedBox(width: 16.w),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image with Blur Effect
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(color: AppColor.borderColor),
              )
            else
              const ColoredBox(color: AppColor.borderColor),

            // Backdrop Filter Frosted Glass Blur
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),

            // Gradient Tint Overlay to blend smoothly with scaffold background
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.28),
                      Colors.transparent,
                      AppColor.bgColor.withOpacity(0.85),
                      AppColor.bgColor,
                    ],
                    stops: const [0.0, 0.45, 0.88, 1.0],
                  ),
                ),
              ),
            ),

            // Center Floating Hero Book Cover
            Positioned(
              bottom: 24.h,
              left: 0,
              right: 0,
              child: Center(
                child: Hero(
                  tag: heroTag,
                  child: Container(
                    width: 165.w,
                    height: 235.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.22),
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 8,
                          offset: const Offset(-2, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: AppColor.borderColor,
                                child: Icon(
                                  Icons.menu_book_rounded,
                                  color: AppColor.grayColor,
                                  size: 48.sp,
                                ),
                              ),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: AppColor.borderColor.withOpacity(0.4),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppColor.mainColor,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: AppColor.borderColor,
                              child: Icon(
                                Icons.menu_book_rounded,
                                color: AppColor.grayColor,
                                size: 48.sp,
                              ),
                            ),
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

/// Custom Frosted Glass Circular Icon Button
class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;
  final double? iconSize;

  const _GlassIconButton({
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: 42.r,
          height: 42.r,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(50.r),
              child: Center(
                child: Icon(
                  icon,
                  size: iconSize ?? 18.sp,
                  color: iconColor ?? AppColor.darkColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
