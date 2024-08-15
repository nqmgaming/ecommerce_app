part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class GetCart extends CartEvent {
  final String userId;

  GetCart(this.userId);
}

final class AddCart extends CartEvent {
  final CartEntity cart;

  AddCart(this.cart);
}

final class RemoveCart extends CartEvent {
  final CartEntity cart;

  RemoveCart(this.cart);
}

final class UpdateCart extends CartEvent {
  final String id;
  final int quantity;

  UpdateCart({required this.id, required this.quantity});
}

final class ClearCart extends CartEvent {
  final String userId;

  ClearCart(this.userId);
}

final class CheckoutCart extends CartEvent {}

final class CartErrorEvent extends CartEvent {
  final String message;

  CartErrorEvent(this.message);
}
