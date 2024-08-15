import 'dart:async';

import 'package:ecommerce_app/core/utils/user_session.dart';
import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/notification_repository.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/notification/add_notification.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/notification/delete_notification.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/notification/get_all_notification_by_user_id.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/notification/read_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';

part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final AddNotification _addNotification;
  final GetAllNotificationByUserId _getAllNotificationByUserId;
  final NotificationRepository _notificationRepository;
  final ReadNotification _readNotification;
  final DeleteNotification _deleteNotification;
  final UserSession _userSession;

  NotificationBloc(
    this._addNotification,
    this._getAllNotificationByUserId,
    this._notificationRepository,
    this._userSession,
    this._readNotification,
    this._deleteNotification,
  ) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) {
      emit(NotificationLoading());
    });
    on<AddNotificationEvent>(_addNotificationEvent);
    on<GetNotificationEvent>(_getAllNotification);
    on<ReadNotificationEvent>(_readNotificationEvent);
    on<DeleteNotificationEvent>(_deleteNotificationEvent);

    _notificationRepository.notificationStream.listen(
      (notifications) async {
        final userId = await _userSession.getUserId();
        add(GetNotificationEvent(userId));
      },
    );
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

  FutureOr<void> _readNotificationEvent(
      ReadNotificationEvent event, Emitter<NotificationState> emit) async {
    final result =
        await _readNotification(ReadNotificationParams(event.notificationId));
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (isRead) {
        emit(NotificationRead(isRead));
      },
    );
  }

  FutureOr<void> _deleteNotificationEvent(
      DeleteNotificationEvent event, Emitter<NotificationState> emit) async {
    final result = await _deleteNotification(
        DeleteNotificationParams(event.notificationId));
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (isDeleted) {
        emit(NotificationDeleted(isDeleted));
      },
    );
  }
}
