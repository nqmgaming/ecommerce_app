import 'package:ecommerce_app/core/constants/images_constant.dart';
import 'package:ecommerce_app/core/utils/user_session.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/login_page.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<String> _userName;
  late Future<String> _userEmail;
  late Future<String> _avatarUrl;

  @override
  void initState() {
    super.initState();
    final userSession = UserSession();
    _userName = userSession.getName();
    _userEmail = userSession.getEmail();
    _avatarUrl = userSession.getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(delegate.profilePageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<String>(
                future: _avatarUrl,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(ImageConstant.defaultAvatar),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(snapshot.data ?? ''),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<String>(
                future: _userName,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                      delegate.errorLoadingName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              FutureBuilder<String>(
                future: _userEmail,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                      delegate.errorLoadingEmail,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    );
                  } else {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Remove access_token from secure storage
                  const secureStorage = FlutterSecureStorage();
                  await secureStorage.delete(key: "access_token");
                  // Clear all user data
                  final userSession = UserSession();
                  await userSession.clearUserData();
                  // Navigate to login page
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                        context, LoginPage.route(), (route) => false);
                  }
                },
                child: Text(delegate.logoutButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
