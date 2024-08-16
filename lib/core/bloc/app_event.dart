part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class AppChangeLocale extends AppEvent {
  final Locale locale;

  AppChangeLocale(this.locale);
}
