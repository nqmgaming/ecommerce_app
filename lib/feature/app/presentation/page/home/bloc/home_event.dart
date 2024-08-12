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

final class ProductPageLoad extends HomeEvent {
  final int categoryId;

  ProductPageLoad({
    required this.categoryId,
  });
}
