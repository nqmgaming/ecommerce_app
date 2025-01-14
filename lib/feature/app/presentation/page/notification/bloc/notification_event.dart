part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class GetNotificationEvent extends NotificationEvent {
  final String userId;

  GetNotificationEvent(this.userId);
}

class AddNotificationEvent extends NotificationEvent {
  final NotificationEntity notificationEntity;

  AddNotificationEvent(this.notificationEntity);
}

class ReadNotificationEvent extends NotificationEvent {
  final String notificationId;

  ReadNotificationEvent(this.notificationId);
}

class DeleteNotificationEvent extends NotificationEvent {
  final String notificationId;

  DeleteNotificationEvent(this.notificationId);
}
