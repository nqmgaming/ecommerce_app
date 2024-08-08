part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<CategoryEntity> categories;

  HomeLoaded(this.categories);
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

final class HomeNoResults extends HomeState {}