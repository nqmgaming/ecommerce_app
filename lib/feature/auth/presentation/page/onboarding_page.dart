import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/core/constants/images_constant.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/login_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/widget/blur_button.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => const OnboardingPage());
  }

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _checkOnboardingSeen();
  }

  Future<void> _checkOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seen = prefs.getBool('onboarding_seen');

    if (seen ?? false) {
      _checkMounted();
    }
  }

  void _checkMounted() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        LoginPage.route(),
      );
    }
  }

  Future<void> _setOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
  }

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
        const SizedBox(height: 30),
        Text(title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: FontConstants.productSansBold)),
        const SizedBox(height: 10),
        Text(description,
            style: const TextStyle(
                fontSize: 12, fontFamily: FontConstants.productSansRegular),
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
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.black.withOpacity(0.5)],
            stops: const [0.5, 0.5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Swiper(
              onIndexChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _buildPages()[index];
              },
              itemCount: _buildPages().length,
              layout: SwiperLayout.DEFAULT,
              itemWidth: MediaQuery.of(context).size.width,
              itemHeight: MediaQuery.of(context).size.height,
              viewportFraction: 0.65,
              scale: 0.7,
              autoplay: true,
            ),
            Positioned(
              bottom: 100,
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
                  const SizedBox(height: 20),
                  BlurButton(
                      onPressed: () async {
                        await _setOnboardingSeen();
                        _checkMounted();
                      },
                      title: "Shopping Now")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
