import 'package:bookia/core/theam/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/services/locale/locale_helper.dart';
import 'core/utils/app_const/app_Const.dart';

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'DM',
          scaffoldBackgroundColor: AppColor.bgColor,
        ),
        initialRoute: initalPage(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
      String initalPage() {
    if (LocaleHelper.prefs?.getString(AppConst.userToken) != null) {
      return AppRoutes.bottonNavBarScreen;
    } else {
      return AppRoutes.loginScreen;
    }
      }
}