part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

final class GetUserInfoEvent extends AuthEvent {
  final String session;

  GetUserInfoEvent({
    required this.session,
  });
}