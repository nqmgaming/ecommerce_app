import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/data/datasource/remote/product_remote_data_source.dart';
import 'package:ecommerce_app/feature/app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl(this._productRemoteDataSource);

  @override
  Future<Either<Failure, ProductEntity>> getProduct(int id) async {
    try {
      final product = await _productRemoteDataSource.getProduct(id);
      return Right(product);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await _productRemoteDataSource.getProducts();
      return Right(products);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int categoryId) async {
    try {
      final products =
          await _productRemoteDataSource.getProductsByCategory(categoryId);
      return Right(products);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
