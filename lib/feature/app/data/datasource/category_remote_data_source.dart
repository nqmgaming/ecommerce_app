import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/constants/apps_constant.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/data/model/category_model.dart';
import 'package:injectable/injectable.dart';

abstract interface class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final _dio = Dio();

  @override
  Future<List<CategoryModel>> getCategories() async {
    const url = '${AppsConstant.baseUrl}categories';
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<CategoryModel> categories = [];
        for (var item in response.data) {
          categories.add(CategoryModel.fromJson(item));
        }
        return categories
            .where((category) => category.name != 'Testing Category')
            .where((category) => category.name != 'nisa')
            .where((category) => category.name != 'hola')
            .toList();
      } else {
        throw Exception('Failed to get categories: ${response.statusCode}');
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
