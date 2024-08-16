import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/constants/apps_constant.dart';
import 'package:ecommerce_app/core/error/failure.dart';
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
  Future<ProductModel> getProduct(int id) async {
    final url = "${AppsConstant.baseUrl}products$id";
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Failure(message: e.response?.data['message']);
      } else {
        throw Failure(message: e.message.toString());
      }
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    const url = "${AppsConstant.baseUrl}products";
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<ProductModel> products = [];
        for (var item in response.data) {
          products.add(ProductModel.fromJson(item));
        }
        return products;
      } else {
        throw Exception('Failed to get products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Failure(message: e.response?.data['message']);
      } else {
        throw Failure(message: e.message.toString());
      }
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    final url = "${AppsConstant.baseUrl}categories/$categoryId/products";
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<ProductModel> products = [];
        for (var item in response.data) {
          products.add(ProductModel.fromJson(item));
        }
        return products;
      } else {
        throw Exception('Failed to get products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Failure(message: e.response?.data['message']);
      } else {
        throw Failure(message: e.message.toString());
      }
    }
  }
}
