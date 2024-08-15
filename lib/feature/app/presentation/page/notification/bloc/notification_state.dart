part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;

  NotificationLoaded(this.notifications);
}

final class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}

final class NotificationAdded extends NotificationState {
  final bool isAdded;

  NotificationAdded(this.isAdded);
}

final class NotificationRead extends NotificationState {
  final bool isUpdated;

  NotificationRead(this.isUpdated);
}

final class NotificationDeleted extends NotificationState {
  final bool isDeleted;

  NotificationDeleted(this.isDeleted);
}
