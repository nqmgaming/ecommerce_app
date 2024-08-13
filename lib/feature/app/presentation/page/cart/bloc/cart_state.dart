part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartEntity> cart;

  CartLoaded(this.cart);
}

final class CartAdded extends CartState {
  final CartEntity cart;

  CartAdded(this.cart);
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}
