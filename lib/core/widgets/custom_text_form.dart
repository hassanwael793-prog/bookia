import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theam/app_color.dart';
import '../theam/app_text_style.dart';

class CustomTextForm extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final bool? autofocus;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;


  const CustomTextForm({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.autofocus,
    this.onSaved,

  });

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // امسح سطر onChanged القديم وجرب ده:
      onChanged: widget.onSaved,
      autofocus: widget.autofocus ?? false,
      controller: widget.controller,
      validator: widget.validator,
      cursorColor: AppColor.mainColor,
      obscureText: widget.isPassword && isObscure,
      onTapOutside: (V) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(Icons.visibility),
              )
            : null,
        fillColor: Colors.white,
        filled: true,
        hintStyle: AppTextStyle().hintStyle,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(color: AppColor.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(color: AppColor.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(color: AppColor.mainColor),
        ),
      ),
    );
  }
}
