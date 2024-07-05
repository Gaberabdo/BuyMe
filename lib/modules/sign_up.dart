import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/cubits/home_cubit/home_states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../layout/home_layout.dart';
import '../shared/components/components.dart';
import '../shared/network/styles/colors.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          if (!state.model.status) {
            defaultToast(
              context: context,
              message: state.model.message,
              iconColor: Colors.red,
              icon: Icons.error_outline_rounded,
            );
          } else {
            CacheHelper.saveData(key: 'token', value: state.model.data!.token);
            HomeCubit.get(context).getProfileData();
            HomeCubit.get(context).getHomeData();
            HomeCubit.get(context).getFavorites();
            navigateAndRemove(context, HomeLayout());
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: logo,
            titleSpacing: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(
                              color: cubit.isDark ? Colors.white : black,
                              fontSize: 36.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5.0
                          ),
                          Text(
                            'Please fill in the following fields.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 40.0
                          ),
                          if (state is SignUpLoadingState)
                            LinearProgressIndicator(
                              color: blue,
                            ),
                          //name
                          defaultTFF(
                              controller: nameController,
                              text: 'Name',
                              keyboardType: TextInputType.text,
                              prefixIcon: Icons.person,
                              validate: (value) {
                                if (value != null && value == '')
                                  return 'Please, Enter Your Name';
                              }),
                          SizedBox(
                            height: 20.0
                          ),
                          //email
                          defaultTFF(
                              controller: emailController,
                              text: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.alternate_email,
                              validate: (value) {
                                if (value != null && value == '')
                                  return 'Please, Enter an Email';
                              }),
                          SizedBox(
                            height: 20.0
                          ),
                          //password
                          defaultTFF(
                              controller: passwordController,
                              isObscure: cubit.isObscure,
                              text: 'Password',
                              prefixIcon: Icons.lock_outline_rounded,
                              suffixIcon: cubit.obscureIcon,
                              onPressedSuffix: () {
                                cubit.changeVisibility();
                              },
                              validate: (value) {
                                if (value != null && value == '')
                                  return 'Please, Enter your password';
                              }),
                          SizedBox(
                            height: 20.0
                          ),
                          defaultTFF(
                              controller: phoneController,
                              text: 'Phone',
                              keyboardType: TextInputType.phone,
                              prefixIcon: Icons.phone,
                              validate: (value) {
                                if (value != null && value == '')
                                  return 'Please, Enter Your Phone Number';
                              }),
                          SizedBox(
                            height: 40.0
                          ),
                          //Login Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.signUp(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
