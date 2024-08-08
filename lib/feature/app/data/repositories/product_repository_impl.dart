import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Either<Failure, ProductEntity>> getProduct(int id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int categoryId) {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }
}
