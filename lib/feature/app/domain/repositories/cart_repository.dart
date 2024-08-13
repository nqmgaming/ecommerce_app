import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getCartByUser(String userId);

  Future<Either<Failure, CartEntity>> addCart(CartEntity cart);

  Future<Either<Failure, CartEntity>> updateCart(CartEntity cart);

  Future<Either<Failure, CartEntity>> deleteCart(CartEntity cart);
}
