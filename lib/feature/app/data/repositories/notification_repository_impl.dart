import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/data/datasource/local/dao/notification_dao.dart';
import 'package:ecommerce_app/feature/app/data/datasource/local/database.dart';
import 'package:ecommerce_app/feature/app/data/model/notification_model.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final AppDatabase _appDatabase;

  const NotificationRepositoryImpl(this._appDatabase);

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
      );

      await notificationDao.insertNotification(notificationModel);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
