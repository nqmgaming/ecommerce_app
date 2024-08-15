import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class NotificationRepository {
  Future<Either<Failure, bool>> insertNotification(
      NotificationEntity notification);

  Future<Either<Failure, List<NotificationEntity>>> getNotifications(String userId);
}
