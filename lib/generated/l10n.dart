// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log into\nyour account`
  String get loginTitle {
    return Intl.message(
      'Log into\nyour account',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailHint {
    return Intl.message(
      'Email address',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHint {
    return Intl.message(
      'Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the required fields`
  String get pleaseFillRequired {
    return Intl.message(
      'Please fill in the required fields',
      name: 'pleaseFillRequired',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get loginButton {
    return Intl.message(
      'Log in',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Or log in with`
  String get orLoginWith {
    return Intl.message(
      'Or log in with',
      name: 'orLoginWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to GemStore!`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to GemStore!',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `\n\nThe home for a fashionista`
  String get homeForFashionista {
    return Intl.message(
      '\n\nThe home for a fashionista',
      name: 'homeForFashionista',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStartedButton {
    return Intl.message(
      'Get Started',
      name: 'getStartedButton',
      desc: '',
      args: [],
    );
  }

  /// `20% Discount New Arrival Product`
  String get discoverSomethingNew {
    return Intl.message(
      '20% Discount New Arrival Product',
      name: 'discoverSomethingNew',
      desc: '',
      args: [],
    );
  }

  /// `Publish up your selfies to make yourself more beautiful with this app.`
  String get specialNewArrivals {
    return Intl.message(
      'Publish up your selfies to make yourself more beautiful with this app.',
      name: 'specialNewArrivals',
      desc: '',
      args: [],
    );
  }

  /// `Take Advantage Of The Offer Shopping`
  String get updateTrendyOutfit {
    return Intl.message(
      'Take Advantage Of The Offer Shopping',
      name: 'updateTrendyOutfit',
      desc: '',
      args: [],
    );
  }

  /// `Favorite brands and hottest trends`
  String get favoriteBrands {
    return Intl.message(
      'Favorite brands and hottest trends',
      name: 'favoriteBrands',
      desc: '',
      args: [],
    );
  }

  /// `All Types Offers Within Your Reach`
  String get exploreTrueStyle {
    return Intl.message(
      'All Types Offers Within Your Reach',
      name: 'exploreTrueStyle',
      desc: '',
      args: [],
    );
  }

  /// `Relax and let us bring the style to you`
  String get relaxBringStyle {
    return Intl.message(
      'Relax and let us bring the style to you',
      name: 'relaxBringStyle',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Now`
  String get shoppingNow {
    return Intl.message(
      'Shopping Now',
      name: 'shoppingNow',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profilePageTitle {
    return Intl.message(
      'Profile',
      name: 'profilePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Error loading name`
  String get errorLoadingName {
    return Intl.message(
      'Error loading name',
      name: 'errorLoadingName',
      desc: '',
      args: [],
    );
  }

  /// `Error loading email`
  String get errorLoadingEmail {
    return Intl.message(
      'Error loading email',
      name: 'errorLoadingEmail',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutButton {
    return Intl.message(
      'Logout',
      name: 'logoutButton',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeLabel {
    return Intl.message(
      'Home',
      name: 'homeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cartLabel {
    return Intl.message(
      'Cart',
      name: 'cartLabel',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alertLabel {
    return Intl.message(
      'Alert',
      name: 'alertLabel',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileLabel {
    return Intl.message(
      'Profile',
      name: 'profileLabel',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get noNotifications {
    return Intl.message(
      'No notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteNotification {
    return Intl.message(
      'Delete',
      name: 'deleteNotification',
      desc: '',
      args: [],
    );
  }

  /// `Error loading notifications`
  String get errorLoadingNotifications {
    return Intl.message(
      'Error loading notifications',
      name: 'errorLoadingNotifications',
      desc: '',
      args: [],
    );
  }

  /// `{date}`
  String notificationDateFormat(Object date) {
    return Intl.message(
      '$date',
      name: 'notificationDateFormat',
      desc: '',
      args: [date],
    );
  }

  /// `Order Successful`
  String get orderSuccessfulTitle {
    return Intl.message(
      'Order Successful',
      name: 'orderSuccessfulTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been placed successfully`
  String get orderSuccessfulContent {
    return Intl.message(
      'Your order has been placed successfully',
      name: 'orderSuccessfulContent',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okCaption {
    return Intl.message(
      'OK',
      name: 'okCaption',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `No items in cart`
  String get noItemsInCart {
    return Intl.message(
      'No items in cart',
      name: 'noItemsInCart',
      desc: '',
      args: [],
    );
  }

  /// `Total ({count} items): `
  String total(Object count) {
    return Intl.message(
      'Total ($count items): ',
      name: 'total',
      desc: '',
      args: [count],
    );
  }

  /// `Search Categories`
  String get searchCategories {
    return Intl.message(
      'Search Categories',
      name: 'searchCategories',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `No categories found`
  String get noCategoriesFound {
    return Intl.message(
      'No categories found',
      name: 'noCategoriesFound',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alertTitle {
    return Intl.message(
      'Alert',
      name: 'alertTitle',
      desc: '',
      args: [],
    );
  }

  /// `Product added to cart`
  String get productAddedToCart {
    return Intl.message(
      'Product added to cart',
      name: 'productAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add product to cart`
  String get failedToAddProductToCart {
    return Intl.message(
      'Failed to add product to cart',
      name: 'failedToAddProductToCart',
      desc: '',
      args: [],
    );
  }

  /// `Available in stock`
  String get availableInStock {
    return Intl.message(
      'Available in stock',
      name: 'availableInStock',
      desc: '',
      args: [],
    );
  }

  /// `Select Color`
  String get selectColor {
    return Intl.message(
      'Select Color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Select Size`
  String get selectSize {
    return Intl.message(
      'Select Size',
      name: 'selectSize',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Please select size and color`
  String get selectSizeAndColor {
    return Intl.message(
      'Please select size and color',
      name: 'selectSizeAndColor',
      desc: '',
      args: [],
    );
  }

  /// `(320 Reviews)`
  String get reviews {
    return Intl.message(
      '(320 Reviews)',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `No products available`
  String get noProductsAvailable {
    return Intl.message(
      'No products available',
      name: 'noProductsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResultsFound {
    return Intl.message(
      'No results found',
      name: 'noResultsFound',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
