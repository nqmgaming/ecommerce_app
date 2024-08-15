import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteNotification implements UseCase<bool, DeleteNotificationParams> {
  final NotificationRepository notificationRepository;

  DeleteNotification(this.notificationRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteNotificationParams params) {
    return notificationRepository.deleteNotification(params.notificationId);
  }
}

class DeleteNotificationParams {
  final String notificationId;

  DeleteNotificationParams(this.notificationId);
}
