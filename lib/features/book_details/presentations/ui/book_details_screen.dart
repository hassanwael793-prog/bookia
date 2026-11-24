import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theam/app_color.dart';
import '../cuibt/book_details_cubit.dart';
import '../widgets/book_bottom_action_bar.dart';
import '../widgets/book_details_error_view.dart';
import '../widgets/book_details_shimmer.dart';
import '../widgets/book_details_sliver_app_bar.dart';
import '../widgets/book_header_info.dart';
import '../widgets/book_meta_stats.dart';
import '../widgets/expandable_description.dart';

class BookDetailsScreen extends StatelessWidget {
  final int? bookId;

  const BookDetailsScreen({
    super.key,
    this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        if (state is BookDetailsLoading) {
          return const BookDetailsShimmer();
        }

        if (state is BookDetailsError) {
          final cubit = context.read<BookDetailsCubit>();
          final resolvedId = bookId ??
              cubit.currentBookId ??
              (ModalRoute.of(context)?.settings.arguments as int?);

          return BookDetailsErrorView(
            onRetry: () {
              if (resolvedId != null) {
                cubit.GetDetails(resolvedId);
              }
            },
          );
        }

        if (state is BookDetailsSuccess) {
          final book = state.details?.data;

          return Scaffold(
            backgroundColor: AppColor.bgColor,
            bottomNavigationBar: BookBottomActionBar(book: book),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Hero SliverAppBar with frosted glass effect & interactive actions
                BookDetailsSliverAppBar(book: book),

                // 2. Main Content Card with rounded top sheet feel
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Tags, Title, Author & Price
                        BookHeaderInfo(book: book),

                        20.verticalSpace,

                        // Key Meta Statistics (Rating, Pages, Language, Stock)
                        BookMetaStats(book: book),

                        24.verticalSpace,

                        const Divider(color: AppColor.borderColor, height: 1),

                        20.verticalSpace,

                        // Expandable "About the Book" Section
                        ExpandableDescription(description: book?.description),

                        36.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const BookDetailsShimmer();
      },
    );
  }
}
