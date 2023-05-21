import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/home_data_model.dart';
import '../../../shared/cubits/home_cubit/home_cubit.dart';
import '../../../shared/cubits/home_cubit/home_states.dart';




class Productdetails extends StatelessWidget {
  Productdetails({required this.product});
  Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=>HomeCubit(),

    child:BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=HomeCubit.get(context);

          return Scaffold(

            body: Container(margin: EdgeInsets.only(bottom: 30),
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  elevation: 0,
                  title: Text('Product Detials',style: GoogleFonts.arefRuqaaInk(
                      fontSize: 25,
                      fontWeight:FontWeight.bold,
                    color: Colors.black87
                  ),),
                  expandedHeight: 200,
                  pinned: true,
                  centerTitle: true,
                  backgroundColor:Colors.green.shade200,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.network(product.image,
                          height: 250,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          height: 300,
                          decoration:
                          BoxDecoration(color:Colors.green.shade300),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 40),
                              child: Column(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text('Details',style: GoogleFonts.arimaMadurai(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87
                                    ),),
                                  ),

                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text('Descripation :  ${product.name} ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20
                                          ),),
                                      ),
                                    ],
                                  ),

                                  Text('Price :  ${product.price}  ',
                                    style: GoogleFonts.arimaMadurai(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),),





                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ),

              ]),
            ),
            bottomSheet: bottomsheet(),
          );

      },

    )

    );
  }

}
Widget bottomsheet(){
  return   Container(
    margin: EdgeInsets.only(top: 10,),
    decoration: BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: MaterialButton(onPressed: (){},
                  child:IconButton(onPressed: (){},
                      icon:Icon(Icons.add_shopping_cart) )),
            ),
          ),
          SizedBox(
            width: 8,
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: MaterialButton(onPressed: (){},
                child: Text('BUY NOW'),),
            ),
          ),


        ],

      ),
    ),
  );
}
