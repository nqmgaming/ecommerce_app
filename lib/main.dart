import 'package:ecommerce_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/login_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/welcome_page.dart';
import 'package:ecommerce_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              home: snapshot.hasData && snapshot.data == true
                  ? const LoginPage()
                  : const WelcomePage(),
            ),
          );
        }
      },
    );
  }
}
