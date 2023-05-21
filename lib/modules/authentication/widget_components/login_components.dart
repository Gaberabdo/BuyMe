import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/modules/authentication/widget_components/validator_components.dart';

import '../../homePage/home_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubits/home_cubit/home_cubit.dart';
import '../../../shared/cubits/login_cubit/login_cubit.dart';
import '../../../shared/cubits/login_cubit/login_states.dart';
import '../../../shared/network/local/cache_helper.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({
    Key? key,
    required this.isSwitch,
    required this.passwordController,
    required this.isPass,
    required this.emailController,
  }) : super(key: key);
  bool isPass;
  bool isSwitch;

  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}
//ignore: must_be_immutable
class _LoginWidgetState extends State<LoginWidget> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status) {
            defaultToast(
                context: context,
                message: state.loginModel.message,
                iconColor: Colors.lightGreen,
                icon: Icons.check_circle);
            CacheHelper.saveData(
                key: 'token', value: state.loginModel.data?.token);
            HomeCubit.get(context).getHomeData();
            HomeCubit.get(context).getFavorites();
            HomeCubit.get(context).getCart();
            HomeCubit.get(context).getProfileData();
            navigateAndRemove(context,  HomeLayout());
          } else {
            defaultToast(
                context: context,
                message: state.loginModel.message,
                iconColor: Colors.red,
                icon: Icons.dangerous);
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: widget.emailController,
                validator: validator,

                decoration: InputDecoration(
                    label: const Text('Email'),
                    hintText: 'example@gmail.com',
                    prefixIcon: const Icon(
                      Icons.alternate_email,
                      size: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(strokeAlign: 1))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                validator: validator,
                controller: widget.passwordController,
                obscureText: widget.isPass,
                decoration: InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(
                      Icons.password,
                      size: 18,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.isPass = !widget.isPass;
                        });
                      },
                      icon: widget.isPass
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(strokeAlign: 1))),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password ?',
                    style: GoogleFonts.eduNswActFoundation(
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ConditionalBuilder(
                condition: state is! LoginLoadingState,
                builder: (Context) => MaterialButton(
                  color: const Color(0xFF0C9869),
                  minWidth: double.infinity,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      LoginCubit.get(context).LogIn(
                        email: widget.emailController.text.toString(),
                        password:widget.passwordController.text.toString(),
                      );
                    }
                  },
                  child:Text(
                    'LOGIN',
                    style: GoogleFonts.eduNswActFoundation(
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
                fallback: (context) => Padding(
                  padding: EdgeInsets.only(right: 40.0.w),
                  child: loading,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 1,
                    color: Colors.black,
                    width: 100,
                  ),
                  const Text('Or'),
                  Container(
                    height: 1,
                    color: Colors.black,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
