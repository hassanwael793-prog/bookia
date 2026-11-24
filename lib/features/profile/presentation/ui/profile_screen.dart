import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/ui/widgets/profile_action_buttons.dart';
import 'package:bookia/features/profile/presentation/ui/widgets/profile_app_bar.dart';
import 'package:bookia/features/profile/presentation/ui/widgets/profile_error_view.dart';
import 'package:bookia/features/profile/presentation/ui/widgets/profile_header_card.dart';
import 'package:bookia/features/profile/presentation/ui/widgets/profile_info_section.dart';
import 'package:bookia/features/profile/presentation/ui/widgets/profile_menu_section.dart';
import 'package:bookia/features/profile/presentation/ui/widgets/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileAppBar(),
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is GetProfileLoading || state is ProfileInitial) {
                    return const ProfileShimmer();
                  }

                  if (state is GetProfileSuccess) {
                    return RefreshIndicator(
                      color: AppColor.mainColor,
                      backgroundColor: AppColor.witchColor,
                      onRefresh: () async {
                        await context.read<ProfileCubit>().GetProfileData();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileHeaderCard(profileData: state.profileData),
                            20.verticalSpace,
                            ProfileInfoSection(profileData: state.profileData),
                            20.verticalSpace,
                            const ProfileMenuSection(),
                            24.verticalSpace,
                            const ProfileActionButtons(),
                            24.verticalSpace,
                          ],
                        ),
                      ),
                    );
                  }

                  return ProfileErrorView(
                    onRetry: () =>
                        context.read<ProfileCubit>().GetProfileData(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
