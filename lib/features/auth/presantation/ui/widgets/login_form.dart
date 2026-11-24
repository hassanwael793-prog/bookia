import 'package:bookia/core/networking/dio_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/app_router.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/theam/app_color.dart';
import '../../../../../core/utils/app_validator.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var formState = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is loginLoadingState) {
      showDialog(context: context,barrierDismissible: false, builder: (context)=>AlertDialog(
        backgroundColor: Colors.transparent,

        content: Center(child: CircularProgressIndicator()),
      ) );
    }else if(state is loginSuccessState){
      Navigator.pop(context);
      DioFactory.init();
      Navigator.pushNamed(context, AppRoutes.bottonNavBarScreen);
    }else{
      Navigator.pop(context);
      showDialog(context: context, builder: (context)=>AlertDialog(
        content: Text("error"),
      ) );
    }
  },
  child: Form(
      key: formState,
      child: Column(
        children: [
          CustomTextForm(
            controller: emailController,
            hintText: 'Enter your email',
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "Please enter your email";
              }
              if (!AppValidator.isEmailValid(v ?? "")) {
                return "Please enter a valid email";
              }
            },
          ),
          15.verticalSpace,
          CustomTextForm(
            controller: passwordController,
            hintText: 'Enter your password',
            isPassword: true,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "Please enter your password";
              }
              if (v.length < 6) {
                return "Password must be at least 6 characters";
              }
            },
          ),
          30.verticalSpace,
          OnboardingButton(
            text: 'Login',
            onPressed: () {
             if( formState.currentState?.validate()??false){
               context.read<AuthCubit>().login(email: emailController.text, password: passwordController.text);
             };
            },
            backgroundColor: AppColor.mainColor,
          ),
        ],
      ),
    ),
);
  }
}
