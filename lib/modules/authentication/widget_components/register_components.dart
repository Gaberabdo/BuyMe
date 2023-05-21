import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/modules/authentication/widget_components/validator_components.dart';

import '../../homePage/home_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubits/home_cubit/home_cubit.dart';
import '../../../shared/cubits/home_cubit/home_states.dart';
import '../../../shared/network/local/cache_helper.dart';

class RegisterWidget extends StatefulWidget {
  RegisterWidget({
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
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
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
            HomeCubit.get(context).getCart();
            navigateAndRemove(context,  HomeLayout());
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.nameController,
                validator: validator,
                decoration: InputDecoration(
                    label: const Text('Your Name'),
                    prefixIcon: const Icon(
                      Icons.person,
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
                controller: widget.phoneController,
                validator: validator,
                decoration: InputDecoration(
                    label: const Text('Phone'),
                    prefixIcon: const Icon(
                      Icons.call_outlined,
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
                controller: widget.emailController,
                validator: validator,
                decoration: InputDecoration(
                    label: const Text('Email'),
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
                controller: widget.passwordController,
                obscureText: widget.isPass,
                validator: validator,
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
              const SizedBox(
                height: 16,
              ),
              MaterialButton(
                color: const Color(0xFF0C9869),
                minWidth: double.infinity,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.signUp(
                      name: widget.nameController.text,
                      phone: widget.phoneController.text,
                      email: widget.emailController.text,
                      password: widget.passwordController.text,
                    );
                  }
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.eduNswActFoundation(
                      color: Colors.white, fontSize: 16),
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
