import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddNotification implements UseCase<bool, NotificationEntity> {
  final NotificationRepository notificationRepository;

  AddNotification(this.notificationRepository);

  @override
  Future<Either<Failure, bool>> call(NotificationEntity params) {
    return notificationRepository.insertNotification(params);
  }
}
