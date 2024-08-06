import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/core/constants/images_constant.dart';
import 'package:ecommerce_app/feature/auth/presentation/onboarding_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/blur_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => const WelcomePage());
  }

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(ImageConstant.welcome),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            print('Image not found');
          },
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
                text: "Welcome to GemStore!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: FontConstants.productSansBold,
                ),
                children: [
                  TextSpan(
                      text: "\nThe home for a fashionista",
                      style: TextStyle(fontSize: 16))
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          BlurButton(
            title: 'Get Started',
            onPressed: () {
              Navigator.push(context, OnboardingPage.route());
            },
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
