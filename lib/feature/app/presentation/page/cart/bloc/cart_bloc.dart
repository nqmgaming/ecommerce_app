import 'dart:async';

import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/add_to_cart.dart';
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
  final GetAllCartByUserId _getAllCartByUserId;
  final UpdateCartQuantity _updateCartQuantity;
  final DeleteCartById _deleteCartById;

  CartBloc(
    this._addToCart,
    this._getAllCartByUserId,
    this._updateCartQuantity,
    this._deleteCartById,
  ) : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      emit(CartLoading());
    });
    on<AddCart>(_onAddCart);
    on<GetCart>(_onGetAllCart);
    on<UpdateCart>(_onUpdateCart);
    on<RemoveCart>(_onDeleteCart);
  }

  FutureOr<void> _onAddCart(AddCart event, Emitter<CartState> emit) async {
    final result = await _addToCart(event.cart);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) {
        emit(CartAdded(cart));
      },
    );
  }

  FutureOr<void> _onGetAllCart(GetCart event, Emitter<CartState> emit) async {
    final result =
        await _getAllCartByUserId(GetAllCartByUserIdParams(event.userId));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (carts) {
        emit(CartLoaded(carts));
      },
    );
  }

  FutureOr<void> _onUpdateCart(
      UpdateCart event, Emitter<CartState> emit) async {
    final result = await _updateCartQuantity(
        UpdateCartQuantityParams(event.id, event.quantity));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (isUpdated) {
        emit(CartUpdated(isUpdated));
      },
    );
  }

  FutureOr<void> _onDeleteCart(
      RemoveCart event, Emitter<CartState> emit) async {
    final result = await _deleteCartById(DeleteCartByIdParams(event.cart.id));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (isDeleted) {
        emit(CartRemoved(isDeleted));
      },
    );
  }
}
