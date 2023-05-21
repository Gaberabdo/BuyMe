import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/setting/settings_screen.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubits/home_cubit/home_cubit.dart';
import '../../../shared/cubits/home_cubit/home_states.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/styles/colors.dart';
import '../../authentication/sign_screen.dart';
import '../../cart/cart_screen.dart';
import '../../setting/edit_profile_screen.dart';

class DrawerComponents extends StatelessWidget {
  const DrawerComponents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        return SafeArea(
          child: ListTileTheme(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 120, left: 12, bottom: 40),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: CachedNetworkImageProvider(
                          cubit.profileModel!.data.image.toString(),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        cubit.profileModel!.data.name.toString(),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      onTap: () {
                        navigateTo(context, const CartScreen());
                      },
                      leading: Icon(
                        Icons.shopping_bag,
                        color: cubit.isDark ? skin : Colors.black54,
                      ),
                      title: const Text('Cart'),
                    ),
                    ListTile(
                      onTap: () {
                        navigateTo(context, SettingsScreen());
                      },
                      leading: Icon(
                        Icons.person,
                        color: cubit.isDark ? skin : Colors.black54,
                      ),
                      title: const Text('Profile'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.dark_mode_outlined,
                        size: 28.sp,
                        color: cubit.isDark ? skin : Colors.black54,
                      ),
                      title: const Text('Dark Mode'),
                      trailing: Padding(
                        padding: EdgeInsets.all(12.0.h),
                        child: Transform.scale(
                          scale: 1.0.h,
                          child: CupertinoSwitch(
                            value: cubit.isDark,
                            onChanged: (state) {
                              cubit.changeThemeMode(state);
                            },
                            activeColor: cubit.isDark ? skin : teal,
                            thumbColor:
                                cubit.isDark ? asmarFate7 : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      leading: Icon(
                        Icons.settings,
                        color: cubit.isDark ? skin : Colors.black54,
                      ),
                      title: const Text('Settings'),
                    ),
                    SizedBox(
                      width: 140,
                      child: IconButton(
                        onPressed: () {
                          CacheHelper.removeData(key: 'token');
                          navigateAndRemove(context, SignUpScreen());
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Sign Out',
                            ),
                            Icon(
                              Icons.logout,
                              color: cubit.isDark ? skin : Colors.black54,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
