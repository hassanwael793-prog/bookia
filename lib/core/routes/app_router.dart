import 'package:bookia/features/welcom/presantation/ui/welcom_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presantation/ui/login_screen.dart';
import 'app_routes.dart';

class AppRouter {


   static Route? onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (_)=> LoginScreen());
      case AppRoutes.welcomeScreen:
        return MaterialPageRoute(builder: (_)=> WelcomScreen());
    }
  }
}