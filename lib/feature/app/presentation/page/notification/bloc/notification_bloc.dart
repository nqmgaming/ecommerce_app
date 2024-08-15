import 'dart:async';

import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/notification/add_notification.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/notification/get_all_notification_by_user_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';

part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final AddNotification _addNotification;
  final GetAllNotificationByUserId _getAllNotificationByUserId;

  NotificationBloc(
    this._addNotification,
    this._getAllNotificationByUserId,
  ) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) {
      emit(NotificationLoading());
    });
    on<AddNotificationEvent>(_addNotificationEvent);
    on<GetNotificationEvent>(_getAllNotification);
  }

  FutureOr<void> _addNotificationEvent(
      AddNotificationEvent event, Emitter<NotificationState> emit) async {
    final result = await _addNotification(event.notificationEntity);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (isAdded) {
        emit(NotificationAdded(isAdded));
      },
    );
  }

  FutureOr<void> _getAllNotification(
      GetNotificationEvent event, Emitter<NotificationState> emit) async {
    final result = await _getAllNotificationByUserId(
        GetAllNotificationByUserIdParams(event.userId));
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) {
        emit(NotificationLoaded(notifications));
      },
    );
  }
}
