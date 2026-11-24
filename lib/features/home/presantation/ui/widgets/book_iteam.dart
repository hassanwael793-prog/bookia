import 'package:bookia/core/theam/app_color.dart';
import 'package:bookia/features/home/presantation/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../data/models/books_model.dart';

class BookIteam extends StatelessWidget {
  final Products? product;

  const BookIteam({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.bookDetailsScreen,
          arguments: product?.id,
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.r),
        width: 163.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColor.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                product?.image ?? "",
                width: 140.w,
                height: 175.h,
                fit: BoxFit.cover,
              ),
            ),
            20.verticalSpace,
            Text(
              product?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            8.verticalSpace,

            Row(
              children: [
                Expanded(child: Text(product?.price ?? "")),
                IconButton(
                  onPressed: () {
                    context.read<HomeCubit>().addToCart(product?.id ?? 0);
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
