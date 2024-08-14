import 'dart:async';

import 'package:ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/feature/auth/domain/usecase/get_user_info.dart';
import 'package:ecommerce_app/feature/auth/domain/usecase/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final GetUserInfo _getUserInfo;

  AuthBloc(this._login, this._getUserInfo) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) {
        emit(AuthLoading());
      },
    );
    on<LoginEvent>(_loginEvent);
    on<GetUserInfoEvent>(_getUserInfoEvent);
  }

  Future<void> _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    final result =
        await _login(LoginParam(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthLoaded(user)),
    );
  }

  FutureOr<void> _getUserInfoEvent(
      GetUserInfoEvent event, Emitter<AuthState> emit) async {
    final result = await _getUserInfo(GetUserInfoParam(session: event.session));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthGetUserInfo(user)),
    );
  }
}
