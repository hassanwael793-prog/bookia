import 'package:bookia/features/welcom/presantation/ui/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/data/rebo/auth_rebo.dart';
import '../../features/auth/presantation/cubit/auth_cubit.dart';
import '../../features/auth/presantation/ui/login_screen.dart';
import '../../features/book_details/presentations/cuibt/book_details_cubit.dart';
import '../../features/book_details/presentations/ui/book_details_screen.dart';
import '../../features/bottom_nav_bar/presentation/ui/bottom_nav_bar_screen.dart';
import '../../features/home/presantation/cubit/home_cubit.dart';
import '../../features/home/presantation/ui/home_screen.dart';
import '../../features/home/presantation/ui/search_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(AuthRepo()),
            child: const LoginScreen(),
          ),
        );
      case AppRoutes.bottonNavBarScreen:
        return MaterialPageRoute(
          builder: (_) => const BottomNavBarScreen(),
        );
      case AppRoutes.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomScreen());

      case AppRoutes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit()..search(""),
            child: const SearchScreen(),
          ),
        );

      case AppRoutes.bookDetailsScreen:
        int id = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (context)=>BookDetailsCubit()..GetDetails(id),
           child: const BookDetailsScreen(),

        ));

      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit()..getBestSellerBooks(),
            child: const HomeScreen(),
          ),
        );
    }
  }
}
