import 'package:bookia/core/theam/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theam/app_text_style.dart';
import '../../../../core/widgets/app_button.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset("assets/images/welcom.png").image),
      ),
      child: Column(
        children: [
          135.verticalSpace,
          Image.asset("assets/images/splah.png"),
          Text("Order Your Book Now!",style:AppTextStyle().hintStyle,),
          330.verticalSpace,
          OnboardingButton(
            text: 'Login',
            foregroundColor: AppColor.witchColor,
            backgroundColor: AppColor.mainColor,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.loginScreen);
            },
          ),
          15.verticalSpace,
          OnboardingButton(
            text: 'Register',
            foregroundColor: AppColor.darkColor,
            backgroundColor: AppColor.bgColor,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.loginScreen);
            },
          ),
        ],
      ),
    ),
    );
  }
}
