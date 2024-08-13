import 'package:ecommerce_app/feature/auth/presentation/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // remove access_token from secure storage
              const secureStorage = FlutterSecureStorage();
              await secureStorage.delete(key: "access_token");
              // navigate to login page
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                    context, LoginPage.route(), (route) => false);
              }
            },
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
