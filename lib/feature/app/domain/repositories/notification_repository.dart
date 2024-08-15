import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(String userId);
  Future<Either<Failure, bool>> insertNotification(NotificationEntity notification);
  Future<Either<Failure, bool>> readNotification(String id);
  Future<Either<Failure, bool>> deleteNotification(String id);
  Stream<List<NotificationEntity>> get notificationStream;
}