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
