import 'package:ecommerce_app/core/bloc/app_bloc.dart';
import 'package:ecommerce_app/core/utils/firebase_api.dart';
import 'package:ecommerce_app/feature/app/presentation/page/app_page.dart';
import 'package:ecommerce_app/feature/app/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/feature/app/presentation/page/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/feature/app/presentation/page/notification/bloc/notification_bloc.dart';
import 'package:ecommerce_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/login_page.dart';
import 'package:ecommerce_app/feature/auth/presentation/page/welcome_page.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:ecommerce_app/injection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize();
  final accessToken = await AppInitializer.getAccessToken();
  runApp(MyApp(isLoggedIn: accessToken != null));
}

class AppInitializer {
  static Future<void> initialize() async {
    await _initializeDependencies();
    await _initializeFirebase();
    await _initializeNotifications();
  }

  static Future<void> _initializeDependencies() async {
    configureDependencies();
  }

  static Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  static Future<void> _initializeNotifications() async {
    FirebaseApi firebaseApi = FirebaseApi();
    firebaseApi.initNotifications();
  }

  static Future<String?> getAccessToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'access_token');
  }

  static Future<bool> checkOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seen = prefs.getBool('onboarding_seen');
    return seen ?? false;
  }
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  String? _locale;

  Future<bool> _checkOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seen = prefs.getBool('onboarding_seen');
    return seen ?? false;
  }

  Future<String?> _getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale');
  }

  @override
  void initState() {
    super.initState();
    _firebaseApi.initNotifications();
    _getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingSeen(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            navigatorKey: navigatorKey,
          );
        } else {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (context) => getIt<AuthBloc>(),
              ),
              BlocProvider<HomeBloc>(
                create: (context) => getIt<HomeBloc>(),
              ),
              BlocProvider<CartBloc>(
                create: (context) => getIt<CartBloc>(),
              ),
              BlocProvider<NotificationBloc>(
                create: (context) => getIt<NotificationBloc>(),
              ),
              BlocProvider(create: (context) => AppBloc()),
            ],
            child: BlocConsumer<AppBloc, AppState>(
              listener: (context, state) {
                if (state is AppLanguageChanged) {
                  setState(() {
                    _locale = state.locale.languageCode;
                  });

                  // save locale to SharedPreferences
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('locale', state.locale.languageCode);
                  });
                }
              },
              builder: (context, state) {
                return MaterialApp(
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  locale: Locale(_locale ?? 'en'),
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                  home: widget.isLoggedIn
                      ? const AppPage()
                      : (snapshot.hasData && snapshot.data == true
                          ? const LoginPage()
                          : const WelcomePage()),
                );
              },
            ),
          );
        }
      },
    );
  }
}
