import 'package:ecommerce_app/core/utils/user_session.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:ecommerce_app/feature/app/presentation/page/notification/page/notification_page.dart';
import 'package:ecommerce_app/injection.dart';
import 'package:ecommerce_app/main.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationRepository _notificationRepository =
      getIt<NotificationRepository>();
  final UserSession _userSession = UserSession();
  bool _isRequestingPermission = false;

  Future<void> initNotifications() async {
    if (_isRequestingPermission) return;

    _isRequestingPermission = true;
    try {
      await _firebaseMessaging.requestPermission();
    } finally {
      _isRequestingPermission = false;
    }

    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) async {
    if (message.notification != null) {
      final userId = await _userSession.getUserId();
      final userName = await _userSession.getName();
      final userAvatar = await _userSession.getAvatar();
      final notification = NotificationEntity(
        id: message.messageId ?? '',
        userId: userId,
        content: message.notification!.body ?? '',
        fullName: userName,
        profileImage: userAvatar,
        createdAt: DateTime.now().toString(),
      );

      await _notificationRepository.insertNotification(notification);

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const NotificationPage(),
        ),
      );
    }
  }
}
