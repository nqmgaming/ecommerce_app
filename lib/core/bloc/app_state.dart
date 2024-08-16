part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppLanguageChanged extends AppState {
  final Locale locale;

  AppLanguageChanged(this.locale);
}
