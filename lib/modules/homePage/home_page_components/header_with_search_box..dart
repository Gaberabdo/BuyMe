import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/homePage/home_layout.dart';
import 'package:shop_app/modules/homePage/search_screen.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/network/styles/styles.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/styles/colors.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    super.key,
    required this.size,
    required this.function,
  });

  final Size size;
  final Function() function;
  @override
  Widget build(BuildContext context) {
    return Container(
      // Cover 20% of total height
      height: size.height * 0.2,
      margin: const EdgeInsets.only(bottom: 20 * 1.5),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 0,
            ),
            height: size.height * 0.2 - 27,
            width: double.infinity,
            decoration: BoxDecoration(
              color: HomeCubit.get(context).isDark
                  ? asmarFate7
                  : const Color(0xFF0C9869),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: [
                IconButton(onPressed: function, icon: Icon(Icons.more_vert,color: Colors.white,)),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 28.0.sp,
                      color: Colors.white,
                    ),
                    Text(
                      'G2H',
                      style: TextStyle(
                          fontSize: 24.0.sp,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                )              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: const Color(0xFF0C9869).withOpacity(0.23),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    navigateTo(context, SearchScreen());
                  },
                  child: Row(
                    children: <Widget>[
                      Text('Search'),
                      Spacer(),
                      Icon(Icons.search)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
