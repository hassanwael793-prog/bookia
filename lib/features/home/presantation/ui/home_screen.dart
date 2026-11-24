import 'package:bookia/features/home/presantation/ui/widgets/book_iteam.dart';
import 'package:bookia/features/home/presantation/ui/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../gen/assets.gen.dart';
import '../../data/models/books_model.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeAppBar(),
              25.verticalSpace,

              BlocListener<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is AddToCartLoading) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is AddToCartSuccess) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(title: Text("product added successful")),
                    );
                  }
                },
                child: SizedBox.shrink(),
              ),

              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    current is GetBestSellerBooksError ||
                    current is GetBestSellerBooksLoading ||
                    current is GetBestSellerBooksSuccess,
                builder: (context, state) {
                  if (state is GetBestSellerBooksLoading) {
                    return Expanded(
                      child: Skeletonizer(
                        enabled: true,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .52,
                                mainAxisSpacing: 14.h,
                                crossAxisSpacing: 18.w,
                              ),
                          itemBuilder: (context, index) => BookIteam(
                            product: Products(
                              name: "name",
                              price: "555",
                              image: "https://picsum.photos/300/400",
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is GetBestSellerBooksSuccess) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .52,
                          mainAxisSpacing: 14.h,
                          crossAxisSpacing: 18.w,
                        ),
                        itemBuilder: (context, index) =>
                            BookIteam(product: state.products?[index]),
                        itemCount: state.products?.length,
                      ),
                    );
                  } else {
                    return Center(child: Text("error"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
