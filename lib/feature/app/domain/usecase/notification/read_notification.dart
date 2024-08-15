import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReadNotification implements UseCase<bool, ReadNotificationParams> {
  final NotificationRepository notificationRepository;

  ReadNotification(this.notificationRepository);

  @override
  Future<Either<Failure, bool>> call(ReadNotificationParams params) {
    return notificationRepository.readNotification(params.notificationId);
  }
}

class ReadNotificationParams {
  final String notificationId;

  ReadNotificationParams(this.notificationId);
}
