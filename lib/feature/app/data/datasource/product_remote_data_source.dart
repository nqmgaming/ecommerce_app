import 'package:dio/dio.dart';
import 'package:ecommerce_app/feature/app/data/model/product_model.dart';
import 'package:injectable/injectable.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();

  Future<List<ProductModel>> getProductsByCategory(int categoryId);

  Future<ProductModel> getProduct(int id);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final _dio = Dio();

  @override
  Future<ProductModel> getProduct(int id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId) {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }
}
