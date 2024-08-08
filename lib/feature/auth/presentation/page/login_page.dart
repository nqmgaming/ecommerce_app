import 'package:ecommerce_app/core/common/widget/app_text_button.dart';
import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/feature/app/presentation/page/app_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/auth_button.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/social_button.dart';
import 'package:ecommerce_app/feature/app/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              if (state is AuthLoaded) {
                Navigator.pushAndRemoveUntil(
                    context, AppPage.route(), (route) => false);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Log into\nyour account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontConstants.productSansBold,
                            height: 2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 30),
                      AuthTextField(
                        controller: _emailController,
                        hintText: "Email address",
                        validator: (value) {
                          // regex for email validation
                          final emailRegex = RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                          if (value!.isEmpty) {
                            return "Email is required";
                          } else if (!emailRegex.hasMatch(value)) {
                            return "Invalid email address";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppTextButton(
                          onPressed: () {},
                          text: "Forgot password?",
                        ),
                      ),
                      const SizedBox(height: 16),
                      AuthButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please fill in the required fields"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        title: "Log in",
                        isLoading: state is AuthLoading,
                      ),
                      const SizedBox(height: 16),
                      const Text("Or log in with"),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SocialButton(
                              onPressed: () {},
                              imageAsset: "assets/images/ic_google.png",
                            ),
                            SocialButton(
                              onPressed: () {},
                              imageAsset: "assets/images/ic_facebook.png",
                            ),
                            SocialButton(
                              onPressed: () {},
                              imageAsset: "assets/images/ic_apple.png",
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {},
                        child: RichText(
                            text: const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: FontConstants.productSansRegular,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: FontConstants.productSansBold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
