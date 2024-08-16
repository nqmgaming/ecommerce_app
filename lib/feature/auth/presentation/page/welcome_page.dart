import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/core/constants/images_constant.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/onboarding_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/blur_button.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => const WelcomePage());
  }

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstant.welcome),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: delegate.welcomeTitle,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: ColorsConstant.whiteColor,
                    fontFamily: FontConstants.productSansBold,
                  ),
                  children: [
                    TextSpan(
                        text: delegate.homeForFashionista,
                        style: const TextStyle(fontSize: 16))
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            BlurButton(
              title: delegate.getStartedButton,
              onPressed: () {
                Navigator.push(context, OnboardingPage.route());
              },
            ),
            const SizedBox(
              height: 140,
            ),
          ],
        ),
      ),
    );
  }
}
