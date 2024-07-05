import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_states.dart';
import '../shared/components/components.dart';
import '../shared/cubits/home_cubit/home_cubit.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
                title: logo,
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(CupertinoIcons.search, size: 24.0,),
                ),
              ],
              ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0),),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 12.8,
                child: BottomNavigationBar(
                  onTap: (index){
                    cubit.changeNavIndex(index);
                    },
                  unselectedFontSize: 11.0,
                  selectedFontSize: 12.0,
                  currentIndex: cubit.currentIndex,
                  items: cubit.navItems,
                  iconSize: MediaQuery.of(context).size.height / 30.0,
                ),
              ),
            ),
          );
        },
      );
  }
}
