import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_states.dart';
import 'package:shop_app/shared/network/styles/colors.dart';

import '../../shared/components/components.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: HomeCubit.get(context).categoryModel != null,
            builder:(context) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              child: Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildCateItem(HomeCubit.get(context).categoryModel.data.data![index],context),
                  separatorBuilder: (context, index) => SizedBox(height: 20.0,),
                  itemCount: HomeCubit.get(context).categoryModel.data.data!.length,
                ),
              ),
            ),
            fallback:(context) => Center(child: loading),
          );
        },
    );
  }

  ClipRRect buildCateItem(DataModel_C category,context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 7,

        child: RawMaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Column(
            // alignment: Alignment.topLeft,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image:  DecorationImage(
                      image: CachedNetworkImageProvider(
                        category.image
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Text(
                  category.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.eduNswActFoundation(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.w700,
                    color: HomeCubit.get(context).isDark ? Colors.black : Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryBuilder(DataModel_C category, context)
  {
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        print(category.id);
      },
      child: Material(
        borderRadius: BorderRadius.circular(20.0.sp),
        clipBehavior: Clip.hardEdge,
        child: Container(
          color: HomeCubit.get(context).isDark ? asmarFate7 : offWhite,
          height: screenHeight / 4.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: category.image,
                fit: BoxFit.cover,
                height: screenHeight / 4.5,
                width: screenHeight / 4.5,
              ),
              SizedBox(width: 10.0.w,),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0.h),
                  child: Text(
                    category.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w700,
                      color: HomeCubit.get(context).isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward_rounded, size: 26.0.sp, color: skin,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
