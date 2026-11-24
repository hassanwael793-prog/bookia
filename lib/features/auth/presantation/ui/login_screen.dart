import 'package:bookia/core/theam/app_text_style.dart';
import 'package:bookia/features/auth/presantation/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome back! Glad \n to see you, Again!",style: AppTextStyle().font30regular,),
              30.verticalSpace,
              LoginForm(),
            ],
          ),
        ),
      ),


    );
  }
}
