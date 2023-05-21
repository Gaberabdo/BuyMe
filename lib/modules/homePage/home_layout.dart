import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/homePage/search_screen.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_states.dart';
import 'package:shop_app/shared/network/styles/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/cubits/home_cubit/home_cubit.dart';
import '../../shared/network/styles/styles.dart';
import 'home_page_components/drawer_components.dart';
import 'home_page_components/header_with_search_box..dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});
  final advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return AdvancedDrawer(
          controller: advancedDrawerController,
          backdrop: buildBackdrop(context),
          drawer: DrawerComponents(),
          child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(150),
                child:HeaderWithSearchBox(size: MediaQuery.of(context).size, function: () {
                  advancedDrawerController.showDrawer();
                },),
              ),
            ),
            body:cubit.screens[cubit.currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 12.8,
                child: BottomNavigationBar(
                  onTap: (index) {
                    cubit.changeNavIndex(index);
                  },
                  unselectedFontSize: 11.0.sp,
                  selectedFontSize: 12.0.sp,
                  currentIndex: cubit.currentIndex,
                  items: cubit.navItems,
                  iconSize: MediaQuery.of(context).size.height / 30.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Container buildBackdrop(context) => Container(
        color: HomeCubit.get(context).isDark
            ? darkTheme.hintColor
            : Colors.grey.shade300,
      );
}
