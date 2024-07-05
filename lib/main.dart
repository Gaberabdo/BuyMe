import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/modules/onboarding_screen.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_states.dart';
import 'package:shop_app/shared/cubits/login_cubit/login_cubit.dart';
import 'package:shop_app/shared/cubits/onboarding_cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/shared/network/styles/styles.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List(),);
  DioHelper.init();
  await CacheHelper.init();
  String token = CacheHelper.getData(key: 'token') ?? '';
  bool onboardingIsSeen = CacheHelper.getData(key: 'onboardingIsSeen') ?? false;
  Widget startWidget = OnboardingScreen();

  if(onboardingIsSeen)
    {
      if(token != '')
        {
          startWidget = HomeLayout();
        }
      else
      {
        startWidget = LoginScreen();
      }
    }

  runApp(MyApp(startWidget));
}
class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
    );
    return  MultiBlocProvider(
      providers: [
        BlocProvider<OnBoardingCubit>(
            create: (context) => OnBoardingCubit()
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()..getHomeData()
              ..getCategoryData()
              ..getFavorites()
              ..getProfileData(),
        )
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode:  HomeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            home: startWidget,
          );

        },
      ),
    );
  }
}
