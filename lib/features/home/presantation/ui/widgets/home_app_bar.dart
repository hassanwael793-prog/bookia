import 'package:bookia/core/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../gen/assets.gen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar ({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.images.splah.image(
          width: 100.w,

        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.searchScreen);
          }
            ,child:
        SvgPicture.asset(Assets.icons.searchNormal)),

      ]
    );
  }
}
