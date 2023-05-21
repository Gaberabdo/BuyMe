import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/onboarding/widget_components/onboarding_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubits/onboarding_cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/cubits/onboarding_cubit/states.dart';
import '../authentication/sign_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              //page view
              Expanded(
                flex: 4,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemBuilder: (context, index) =>
                      onboardBuildPage(onBoardInfo[index]),
                  itemCount: onBoardInfo.length,
                  onPageChanged: (index) {
                    if (index == onBoardInfo.length - 1) {
                      OnBoardingCubit.get(context).listenPageLastIndex(true);
                    } else {
                      OnBoardingCubit.get(context).listenPageLastIndex(false);
                    }
                  },
                ),
              ),

              //indicator, buttons
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(20.0.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Indicator
                      SmoothPageIndicator(
                        controller: pageController,
                        count: onBoardInfo.length,
                        effect: WormEffect(
                          dotColor: metal,
                          activeDotColor: Color(0xFF0C9869),
                          dotHeight: 10.0.sp,
                          dotWidth: 10.0.sp,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          //Skip
                          TextButton(
                            onPressed: () {
                              CacheHelper.saveData(
                                  key: 'onboardingIsSeen', value: true);
                              navigateAndRemove(context, const SignUpScreen());
                            },
                            child: Text(
                              'SKIP',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: teal,
                              ),
                            ),
                          ),
                          const Spacer(),
                          MaterialButton(
                            padding: EdgeInsets.all(10.0.sp),
                            onPressed: () {
                              if (OnBoardingCubit.get(context).isLastPage) {
                                CacheHelper.saveData(
                                    key: 'onboardingIsSeen', value: true);
                                navigateAndRemove(
                                    context, const SignUpScreen());
                              } else {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              }
                            },
                            color: teal,
                            shape: OnBoardingCubit.get(context).isLastPage
                                ? RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0.sp))
                                : const CircleBorder(),
                            child: OnBoardingCubit.get(context).isLastPage
                                ? Text(
                                    'Get Started',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0.sp,
                                    ),
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                    size: 24.0.sp,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget onboardBuildPage(OnboardingModel pageInfo) => Column(
        // alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Image.asset(
              pageInfo.imagePath,
              height: 400,
            ),
          ),
          Spacer(),
          //upper texts
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  pageInfo.title,
                  textAlign: TextAlign.center,
                  style: textTheme(
                    color: const Color(0xFF0C9869),
                    fontSize: 28.0,
                  ),
                ),
                Text(
                  pageInfo.describtion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: black,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
