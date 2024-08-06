import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/core/constants/images_constant.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/blur_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => const OnboardingPage());
  }

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _buildPages() {
    return [
      _buildPage(
        image: ImageConstant.intro1,
        title: 'Discover something new',
        description: 'Special new arrivals just for you',
      ),
      _buildPage(
        image: ImageConstant.intro2,
        title: 'Update trendy outfit',
        description: 'Favorite brands and hottest trends',
      ),
      _buildPage(
        image: ImageConstant.intro3,
        title: 'Explore your true style',
        description: 'Relax and let us bring the style to you',
      ),
    ];
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 120),
        Text(title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: FontConstants.productSansBold)),
        const SizedBox(height: 10),
        Text(description,
            style: const TextStyle(
                fontSize: 16, fontFamily: FontConstants.productSansRegular),
            textAlign: TextAlign.center),
        const SizedBox(height: 20),
        Image.asset(image, height: 350),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromRGBO(70, 68, 71, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.5],
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _buildPages(),
            ),
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _buildPages().length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 10,
                        width: _currentPage == index ? 20 : 10,
                        decoration: BoxDecoration(
                          color:
                              _currentPage == index ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlurButton(onPressed: () {}, title: "Shopping Now")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
