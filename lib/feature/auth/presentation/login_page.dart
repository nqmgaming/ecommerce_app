import 'package:ecommerce_app/core/common/widget/app_text_button.dart';
import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/auth_button.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/social_button.dart';
import 'package:flutter/material.dart';

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
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
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
                AuthButton(onPressed: () {}, title: "Log in"),
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
        ),
      ),
    );
  }
}
