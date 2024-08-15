import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/data/datasource/local/dao/notification_dao.dart';
import 'package:ecommerce_app/feature/app/data/datasource/local/database.dart';
import 'package:ecommerce_app/feature/app/data/model/notification_model.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'dart:async';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final AppDatabase _appDatabase;
  final _notificationStreamController =
      StreamController<List<NotificationEntity>>.broadcast();

  NotificationRepositoryImpl(this._appDatabase);

  @override
  Stream<List<NotificationEntity>> get notificationStream =>
      _notificationStreamController.stream;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      String userId) async {
    try {
      final db = await _appDatabase.database;
      final notificationDao = NotificationDao(db);
      final notifications = await notificationDao.getAllNotifications(userId);
      final notificationEntities =
          notifications.map((cart) => NotificationModel.fromMap(cart)).toList();
      return Right(notificationEntities);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> insertNotification(
      NotificationEntity notification) async {
    try {
      final db = await _appDatabase.database;
      final notificationDao = NotificationDao(db);
      final notificationModel = NotificationModel(
        id: notification.id,
        userId: notification.userId,
        content: notification.content,
        fullName: notification.fullName,
        profileImage: notification.profileImage,
        createdAt: notification.createdAt,
        isRead: notification.isRead,
      );

      await notificationDao.insertNotification(notificationModel);
      final updatedNotifications =
          await notificationDao.getAllNotifications(notification.userId);
      _notificationStreamController.add(updatedNotifications
          .map((cart) => NotificationModel.fromMap(cart))
          .toList());
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(String id) async {
    try {
      final db = await _appDatabase.database;
      final notificationDao = NotificationDao(db);
      await notificationDao.deleteNotification(id);
      final updatedNotifications = await notificationDao.getAllNotifications(id);
      _notificationStreamController.add(updatedNotifications
          .map((cart) => NotificationModel.fromMap(cart))
          .toList());
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> readNotification(String id) async {
    try {
      final db = await _appDatabase.database;
      final notificationDao = NotificationDao(db);
      await notificationDao.readNotification(id);
      final updatedNotifications = await notificationDao.getAllNotifications(id);
      _notificationStreamController.add(updatedNotifications
          .map((cart) => NotificationModel.fromMap(cart))
          .toList());
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
