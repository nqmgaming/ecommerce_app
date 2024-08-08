part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeLoadCategories extends HomeEvent {}

final class HomeSearchCategories extends HomeEvent {
  final String query;

  HomeSearchCategories({
    required this.query,
  });
}