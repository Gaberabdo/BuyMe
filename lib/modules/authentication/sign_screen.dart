import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/authentication/widget_components/login_components.dart';
import 'package:shop_app/modules/authentication/widget_components/register_components.dart';

import '../../shared/components/components.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPass = true;
  bool isSwitch = true;
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    'https://img.freepik.com/free-vector/simple-blank-green-background-vector-business_53876-174913.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                  ),
                ),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.green],
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 101, 10, 0),
                child: Column(
                  children: [
                    isSwitch
                        ? Text(
                            'Welcome Back',
                            style: textTheme(fontSize: 22),
                          )
                        : Text(
                            'Create Account',
                            style: textTheme(fontSize: 22),
                          ),
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 14,
                              offset: Offset(0.0, 0.75)),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                            isSwitch
                                ? LoginWidget(
                                    isSwitch: isSwitch,
                                    passwordController: passwordController,
                                    isPass: isPass,
                                    emailController: emailController,
                                  )
                                : RegisterWidget(
                                    isSwitch: isSwitch,
                                    passwordController: passwordController,
                                    isPass: isPass,
                                    emailController: emailController),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isSwitch
                                    ? Text(
                                        'Don\'t Have Account?',
                                        style: textTheme(),
                                      )
                                    : Text(
                                        'Have Account?',
                                        style: textTheme(),
                                      ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isSwitch = !isSwitch;
                                      print(isSwitch);
                                    });
                                  },
                                  child: Text(
                                    isSwitch ? 'Sign Up' : 'LOGIN',
                                    style: textTheme(
                                      fontWeight: FontWeight.bold,
                                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
