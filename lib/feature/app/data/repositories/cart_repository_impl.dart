import 'dart:ffi';

import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/data/datasource/local/dao/cart_dao.dart';
import 'package:ecommerce_app/feature/app/data/datasource/local/database.dart';
import 'package:ecommerce_app/feature/app/data/model/cart_model.dart';
import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final AppDatabase _appDatabase;

  CartRepositoryImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<Either<Failure, CartEntity>> addCart(CartEntity cart) async {
    try {
      final db = await _appDatabase.database;
      final cartDao = CartDao(db);
      final cartModel = CartModel(
        id: cart.id,
        userId: cart.userId,
        productId: cart.productId,
        quantity: cart.quantity,
        size: cart.size,
        color: cart.color,
        productName: cart.productName,
        productImage: cart.productImage,
        productPrice: cart.productPrice,
        categoryId: cart.categoryId,
        categoryName: cart.categoryName,
        createdAt: cart.createdAt,
      );
      await cartDao.insertCart(cartModel);
      return Right(cart);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCart(String id) async {
    try {
      final db = await _appDatabase.database;
      final cartDao = CartDao(db);
      await cartDao.deleteCart(id);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCart(String id, int quantity) async {
    try {
      final db = await _appDatabase.database;
      final cartDao = CartDao(db);
      await cartDao.updateCart(id, quantity);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCartByUser(String userId) async {
    try {
      final db = await _appDatabase.database;
      final cartDao = CartDao(db);
      final carts = await cartDao.getAllCartByUser(userId);
      final cartEntities =
          carts.map((cart) => CartModel.fromMap(cart)).toList();
      return Right(cartEntities);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
