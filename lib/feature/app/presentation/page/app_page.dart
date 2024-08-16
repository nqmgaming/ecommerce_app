import 'package:ecommerce_app/feature/app/presentation/page/profile/page/profile_page.dart';
import 'package:ecommerce_app/feature/app/presentation/widget/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import 'cart/page/cart_page.dart';
import 'home/page/home_page.dart';
import 'notification/page/notification_page.dart';

class AppPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => const AppPage());
  }

  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = [
      const HomePage(),
      const CartPage(isMain: false,),
      const NotificationPage(),
      const ProfilePage()
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 3),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: CustomBottomNavigationBarItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: _selectedIndex == 0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomBottomNavigationBarItem(
                  icon: Icons.shopping_cart_rounded,
                  label: 'Cart',
                  isSelected: _selectedIndex == 1,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomBottomNavigationBarItem(
                  icon: Icons.notifications_rounded,
                  label: 'Alert',
                  isSelected: _selectedIndex == 2,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomBottomNavigationBarItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  isSelected: _selectedIndex == 3,
                ),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            showSelectedLabels: false,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
