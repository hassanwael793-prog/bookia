import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/ui/cart_screen.dart';
import 'package:bookia/features/home/presantation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presantation/ui/home_screen.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/ui/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit()..getBestSellerBooks(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => HomeCubit()..getBestSellerBooks(),
      child: HomeScreen(),
    ),
   BlocProvider(
  create: (context) => CartCubit()..getCartData(),
  child: CartScreen(),
),
    BlocProvider(
  create: (context) => ProfileCubit()..GetProfileData(),
  child: ProfileScreen(),
),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.bgColor,
        selectedItemColor: AppColor.mainColor,
        currentIndex: currentIndex,
        onTap: (v) {
          setState(() {
            currentIndex = v;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.home,
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? AppColor.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.bookmark,
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? AppColor.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "favorite",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.category,
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? AppColor.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.profile,
              colorFilter: ColorFilter.mode(
                currentIndex == 3 ? AppColor.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
