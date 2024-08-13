import 'dart:async';

import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/add_to_cart.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/cart/get_all_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'cart_event.dart';

part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart _addToCart;
  final GetAllCartByUserId _getAllCartByUserId;

  CartBloc(this._addToCart, this._getAllCartByUserId) : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      emit(CartLoading());
    });
    on<AddCart>(_onAddCart);
    on<GetCart>(_onGetAllCart);
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
}
