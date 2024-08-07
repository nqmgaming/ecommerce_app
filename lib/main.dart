import 'package:ecommerce_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/login_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/welcome_page.dart';
import 'package:ecommerce_app/feature/home/presentation/page/home_page.dart';
import 'package:ecommerce_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  const secureStorage = FlutterSecureStorage();
  final accessToken = await secureStorage.read(key: 'access_token');

  runApp(MyApp(isLoggedIn: accessToken != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  Future<bool> _checkOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seen = prefs.getBool('onboarding_seen');
    return seen ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingSeen(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (context) => getIt<AuthBloc>(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: isLoggedIn
                  ? const HomePage()
                  : (snapshot.hasData && snapshot.data == true
                      ? const LoginPage()
                      : const WelcomePage()),
            ),
          );
        }
      },
    );
  }
}
