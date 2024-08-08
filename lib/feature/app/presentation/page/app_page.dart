import 'package:ecommerce_app/feature/app/presentation/page/cart_page.dart';
import 'package:ecommerce_app/feature/app/presentation/page/home_page.dart';
import 'package:ecommerce_app/feature/app/presentation/page/notification_page.dart';
import 'package:ecommerce_app/feature/app/presentation/page/profile_page.dart';
import 'package:ecommerce_app/feature/app/presentation/widget/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';

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
      const CartPage(),
      const NotificationPage(),
      const ProfilePage()
    ];
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              icon: Icons.home,
              label: 'Home',
              isSelected: _selectedIndex == 0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              icon: Icons.shopping_cart,
              label: 'Cart',
              isSelected: _selectedIndex == 1,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              icon: Icons.notifications,
              label: 'Notifi',
              isSelected: _selectedIndex == 2,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              icon: Icons.person,
              label: 'Profile',
              isSelected: _selectedIndex == 3,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        showSelectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
