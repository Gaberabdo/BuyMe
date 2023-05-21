import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/homePage/home_layout.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_states.dart';

import '../../shared/components/components.dart';
import 'components/cart_item_components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var total = HomeCubit.get(context).cartModel!.data.total;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart',
              style: textTheme(fontSize: 22),
            ),
          ),
          body: CartItem(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Row(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 27,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            r'$'+ total.round().toString(),
                            style: textTheme(fontSize: 27, color: Colors.teal),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.black54,
                      ),
                      MaterialButton(
                        height: 40,
                        minWidth: double.infinity,
                        color: Colors.teal,
                        onPressed: () {
                          ///todo navigator
                        },
                        child: Text(
                          'Next',
                          style: textTheme(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
