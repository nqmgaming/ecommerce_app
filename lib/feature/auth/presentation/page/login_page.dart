import 'package:ecommerce_app/core/common/widget/app_text_button.dart';
import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/core/constants/images_constant.dart';
import 'package:ecommerce_app/feature/app/presentation/page/app_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/auth_button.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/social_button.dart';
import 'package:ecommerce_app/generated/l10n.dart';
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
    final delegate = S.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
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
              // get user info
              BlocProvider.of<AuthBloc>(context).add(
                GetUserInfoEvent(session: state.userEntity.assetToken!),
              );
            }
            if (state is AuthGetUserInfo) {
              Navigator.pushReplacement(
                context,
                AppPage.route(),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        delegate.loginTitle,
                        style: const TextStyle(
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
                      hintText: delegate.emailHint,
                      validator: (value) {
                        // regex for email validation
                        final emailRegex =
                            RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$');
                        if (value!.isEmpty) {
                          return delegate.emailRequired;
                        } else if (!emailRegex.hasMatch(value)) {
                          return delegate.invalidEmail;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _passwordController,
                      hintText: delegate.passwordHint,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return delegate.passwordRequired;
                        } else if (value.length < 6) {
                          return delegate.passwordTooShort;
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
                        text: delegate.forgotPassword,
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
                            SnackBar(
                              content: Text(delegate.pleaseFillRequired),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      title: delegate.loginButton,
                      isLoading: state is AuthLoading,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      delegate.orLoginWith,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: FontConstants.productSansRegular,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocialButton(
                            onPressed: () {},
                            imageAsset: ImageConstant.icGoogle,
                          ),
                          SocialButton(
                            onPressed: () {},
                            imageAsset: ImageConstant.icFacebook,
                          ),
                          SocialButton(
                            onPressed: () {},
                            imageAsset: ImageConstant.icApple,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {},
                      child: RichText(
                          text: TextSpan(
                        text: delegate.dontHaveAccount,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: FontConstants.productSansRegular,
                        ),
                        children: [
                          TextSpan(
                            text: delegate.signUp,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
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
    );
  }
}
