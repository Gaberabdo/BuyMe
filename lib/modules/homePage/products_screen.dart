import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_data_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_states.dart';
import 'package:shop_app/shared/network/styles/colors.dart';

import 'home_page_components/Product detials.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangeFavSuccessState) {
          if (!state.model.status) {
            defaultToast(
              context: context,
              message: state.model.message,
              iconColor: Colors.red,
              icon: Icons.error_outline,
            );
          } else {
            defaultToast(
              context: context,
              message: state.model.message,
              iconColor: Colors.red,
              icon: state.model.message.contains('Deleted')
                  ? Icons.heart_broken
                  : Icons.favorite,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeDataModel != null &&
              HomeCubit.get(context).categoryModel != null,
          builder: (context) => productsBuilder(
              HomeCubit.get(context).homeDataModel,
              HomeCubit.get(context).categoryModel,
              context),
          fallback: (context) => Center(child: loading),
        );
      },
    );
  }

  Widget productsBuilder(
      HomeDataModel? homeDataModel, CategoryModel categoryModel, context) {
    HomeCubit cubit = HomeCubit.get(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Container(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: homeDataModel?.data.banners.map((e) {
                  return CachedNetworkImage(
                    imageUrl: e.image,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: screenHeight / 4.5,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  reverse: false,
                  viewportFraction: 1.0,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              //Categories

              //products
              Text(
                'New Products',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0.sp,
                    color: cubit.isDark ? Colors.white : Colors.black),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 235.0.h,
                  maxCrossAxisExtent: 300.0,
                  crossAxisSpacing: 10.h,
                  mainAxisSpacing: 10.h,
                ),
                itemBuilder: (context, index) => gridProductBuilder(
                  homeDataModel.data.products[index],
                  context,
                ),
                itemCount: homeDataModel!.data.products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              )
              // GridView.count(
              //   physics: NeverScrollableScrollPhysics(),
              //   crossAxisCount: 2,
              //   shrinkWrap: true,
              //   mainAxisSpacing: 10.0.h,
              //   crossAxisSpacing: 10.0.w,
              //   childAspectRatio: 1 / key.currentContext!.size!.height,
              //   children: List.generate(homeDataModel!.data.products.length,
              //           (index) => gridProductBuilder(homeDataModel.data.products[index], context),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  // Widget gridProductBuilder(Product product, context) {
  //   HomeCubit cubit = HomeCubit.get(context);
  //
  //   return Material(
  //     elevation: 3.0,
  //     borderRadius: BorderRadius.circular(20.0),
  //     color: cubit.isDark ? asmarFate7 : Colors.white,
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Stack(
  //             alignment: Alignment.topRight,
  //             children: [
  //               Stack(
  //                 alignment: Alignment.topLeft,
  //                 children: [
  //                   CachedNetworkImage(
  //                     imageUrl: product.image,
  //                     errorWidget: (context, url, error) =>
  //                         const Icon(Icons.error_outline),
  //                     height: 150.0.h,
  //                     width: double.infinity,
  //                   ),
  //                   if (product.price != product.oldPrice)
  //                     Padding(
  //                       padding: const EdgeInsets.all(5.0),
  //                       child: Container(
  //                         padding: const EdgeInsets.all(2.0),
  //                         decoration: BoxDecoration(
  //                             color: blue,
  //                             borderRadius: BorderRadius.circular(
  //                               5.0,
  //                             )),
  //                         child: Text(
  //                           'Sale',
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 10.0.sp,
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //               //favorites button
  //               InkWell(
  //                 onTap: () {
  //                   product.inFavorites = !product.inFavorites;
  //                   cubit.changeFavorite(product.id);
  //                 },
  //                 splashColor: Colors.transparent,
  //                 highlightColor: Colors.transparent,
  //                 child: CircleAvatar(
  //                   backgroundColor:
  //                       cubit.isDark ? Colors.black.withOpacity(0.8) : offWhite,
  //                   radius: 16.0.sp,
  //                   child: Icon(
  //                     product.inFavorites
  //                         ? Icons.favorite
  //                         : Icons.favorite_outline,
  //                     color: product.inFavorites ? teal : skin,
  //                     size: 19.0.sp,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 5.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   product.name,
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     fontSize: 14.0.sp,
  //                     fontWeight: FontWeight.w600,
  //                     color: cubit.isDark ? Colors.white : Colors.black,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 5.0,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       product.price.round().toString() + ' EGP',
  //                       style: TextStyle(
  //                         fontSize: 15.0.sp,
  //                         color: teal,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 5.0,
  //                     ),
  //                     if (product.price != product.oldPrice)
  //                       Expanded(
  //                         child: Text(
  //                           product.oldPrice.round().toString() + ' EGP',
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                             fontSize: 12.0.sp,
  //                             color: skin,
  //                             decoration: TextDecoration.lineThrough,
  //                           ),
  //                         ),
  //                       ),
  //                     Spacer(),
  //                     InkWell(
  //                       onTap: () {
  //                         product.inCart = !product.inCart;
  //                         cubit.changeCart(product.id);
  //                       },
  //                       splashColor: Colors.transparent,
  //                       highlightColor: Colors.transparent,
  //                       child: CircleAvatar(
  //                         backgroundColor:
  //                         cubit.isDark ? Colors.black.withOpacity(0.8) : offWhite,
  //                         radius: 16.0.sp,
  //                         child: Icon(
  //                           product.inCart
  //                               ? Icons.shopping_cart
  //                               : Icons.remove_shopping_cart,
  //                           color: product.inCart ? teal : skin,
  //                           size: 19.0.sp,
  //                         ),
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget gridProductBuilder(Product product, context) {
    HomeCubit cubit = HomeCubit.get(context);

    return InkWell(
      onTap: () {
        navigateTo(context, Productdetails(product: product));
      },
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(20.0),
        color: cubit.isDark ? Colors.green.shade50 : Colors.green.shade50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      CachedNetworkImage(
                        imageUrl: product.image,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                        height: 140.0.h,
                        width: double.infinity,
                      ),
                      if (product.price != product.oldPrice)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                )),
                            child: Text(
                              'Sale',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  //favorites button
                  InkWell(
                    onTap: () {
                      product.inFavorites = !product.inFavorites;
                      cubit.changeFavorite(product.id);
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: CircleAvatar(
                      backgroundColor: cubit.isDark
                          ? Colors.black.withOpacity(0.8)
                          : offWhite,
                      radius: 16.0.sp,
                      child: Icon(
                        product.inFavorites
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: product.inFavorites ? teal : skin,
                        size: 19.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                        color: cubit.isDark ? Colors.black87 : Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              product.price.round().toString() + ' EGP',
                              style: TextStyle(
                                fontSize: 15.0.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: product.inCart ? Colors.orangeAccent : Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: IconButton(
                                onPressed: () {
                                  product.inCart = !product.inCart;
                                  cubit.changeCart(product.id);
                                  cubit.getCart();
                                },
                                icon: Icon(
                                  Icons.add_shopping_cart_outlined,

                                ))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
