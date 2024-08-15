import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllNotificationByUserId
    implements
        UseCase<List<NotificationEntity>, GetAllNotificationByUserIdParams> {
  final NotificationRepository notificationRepository;

  GetAllNotificationByUserId(this.notificationRepository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
      GetAllNotificationByUserIdParams params) {
    return notificationRepository.getNotifications(params.userId);
  }
}

class GetAllNotificationByUserIdParams {
  final String userId;

  GetAllNotificationByUserIdParams(this.userId);
}
