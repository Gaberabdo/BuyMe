import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/cart_model.dart';
import '../../../models/home_data_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubits/home_cubit/home_cubit.dart';
import '../../../shared/cubits/home_cubit/home_states.dart';
import '../../../shared/network/styles/colors.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangeCartSuccessState) {
          if (state.model.status) {
            defaultToast(
              context: context,
              message: 'Remove Success',
              iconColor: teal,
              icon: Icons.check_circle,
            );
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConditionalBuilder(
            condition: cubit.cartModel!.data.cartItems != null,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  child: buildDismissible(
                      cubit.cartModel!.data.cartItems[index], context),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 20.0.h,
              ),
              itemCount:cubit.cartModel!.data.cartItems.length,
            ),
            fallback: (context) => Center(child: loading),
          ),
        );
      },
    );
  }

  Dismissible buildDismissible(CartItems product, context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return HomeCubit.get(context).changeCart(product.id) as dynamic;
      },

      ///todo enter id product
      key: Key(product.id.toString()),
      background: Container(
        color: Colors.teal.shade800,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                " Delete",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
      child: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: Column(
                    children: [
                      ExpandablePanel(
                        header: Text(
                          product.product.name.substring(0, 30),
                          style: textTheme(
                            fontSize: 16,
                          ),
                        ),
                        collapsed: Text(
                          product.product.description.toString(),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        expanded: Text(
                          product.product.description.toString(),
                          softWrap: true,
                          maxLines: 7,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image(
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        product.product.image.toString(),
                      ),
                    ),
                  ),
                  Text(
                    r'$' + product.product.price.toString(),
                    style: textTheme(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
