import 'package:bookia/core/widgets/custom_text_form.dart';
import 'package:bookia/features/home/presantation/ui/widgets/book_iteam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/books_model.dart';
import '../cubit/home_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new)),
              16.verticalSpace,
            CustomTextForm(hintText: "Search",
              autofocus: true,
              onSaved: (v) {
                // الكود ده مش هيشتغل غير لما المستخدم يخلص كتابة ويدوس Search
                context.read<HomeCubit>().search(v!);
              },),
        20.verticalSpace,

        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
             if(state is SearchLoading){
                return Expanded(
                 child: Skeletonizer(
                   enabled: true,
                   child: GridView.builder(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

            }else if(state is SearchSuccess){
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

            }
            else{
             return Text("error");
            }
          }
        ),

          ],
        ),
      ),

      ),
    );
  }
}
