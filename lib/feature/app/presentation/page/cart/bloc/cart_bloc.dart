import 'dart:async';

import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/add_to_cart.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/delete_all_cart.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/delete_cart_by_id.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/get_all_cart.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/update_cart_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'cart_event.dart';

part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart _addToCart;
  final DeleteAllCart _deleteAllCart;
  final DeleteCartById _deleteCartById;
  final GetAllCartByUserId _getAllCart;
  final UpdateCartQuantity _updateCartQuantity;

  CartBloc(
    this._addToCart,
    this._deleteAllCart,
    this._deleteCartById,
    this._getAllCart,
    this._updateCartQuantity,
  ) : super(CartInitial()) {
    on<AddCart>(_onAddCart);
    on<RemoveCart>(_onDeleteCart);
    on<UpdateCart>(_onUpdateCart);
    on<GetCart>(_onGetCart);
    on<ClearCart>(_onClearCart);
  }

  FutureOr<void> _onAddCart(AddCart event, Emitter<CartState> emit) async {
    final result = await _addToCart(AddToCartParams(event.cart));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartAdded(cart)),
    );
  }

  FutureOr<void> _onDeleteCart(
      RemoveCart event, Emitter<CartState> emit) async {
    final result = await _deleteCartById(DeleteCartByIdParams(event.cart.id));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (isDeleted) => emit(CartRemoved(isDeleted)),
    );
  }

  FutureOr<void> _onUpdateCart(
      UpdateCart event, Emitter<CartState> emit) async {
    final result = await _updateCartQuantity(
        UpdateCartQuantityParams(event.id, event.quantity));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (isUpdated) => emit(CartUpdated(isUpdated)),
    );
  }

  FutureOr<void> _onGetCart(GetCart event, Emitter<CartState> emit) async {
    final result = await _getAllCart(GetAllCartByUserIdParams(event.userId));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  FutureOr<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    print('clear cart');
    final result = await _deleteAllCart(DeleteAllCartParams(event.userId));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (isDeleted) => emit(CartRemovedAll(isDeleted)),
    );
  }
}
