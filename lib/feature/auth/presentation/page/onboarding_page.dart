import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:ecommerce_app/core/constants/images_constant.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/login_page.dart';
import 'package:ecommerce_app/generated/l10n.dart';
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
    final localizations = S.of(context);
    return [
      _buildPage(
        image: ImageConstant.intro1,
        title: localizations.discoverSomethingNew,
        description: localizations.specialNewArrivals,
      ),
      _buildPage(
        image: ImageConstant.intro2,
        title: localizations.updateTrendyOutfit,
        description: localizations.favoriteBrands,
      ),
      _buildPage(
        image: ImageConstant.intro3,
        title: localizations.exploreTrueStyle,
        description: localizations.relaxBringStyle,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                transform: Matrix4.skewY(-0.04),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorsConstant.greyColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: FontConstants.productSansBold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 17,
                fontFamily: FontConstants.productSansRegular,
                color: ColorsConstant.blackColor.withOpacity(0.7),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.whiteColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Swiper(
                onIndexChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return _buildPages()[index];
                },
                fade: 0.5,
                scale: 0.9,
                itemCount: _buildPages().length,
                layout: SwiperLayout.DEFAULT,
                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: MediaQuery.of(context).size.height,
                autoplay: false,
              ),
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    _buildPages().length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 8,
                      width: _currentPage == index ? 25 : 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? ColorsConstant.blackColor
                            : ColorsConstant.greyColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    await _setOnboardingSeen();
                    _checkMounted();
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: ColorsConstant.blackColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorsConstant.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
