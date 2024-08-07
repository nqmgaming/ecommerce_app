import 'package:ecommerce_app/core/constants/apps_constant.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final _dio = Dio();

  // use dio
  @override
  Future<UserModel> login(String email, String password) async {
    const url =
        '${AppsConstant.baseUrl}auth/login'; // Replace with your API endpoint
    try {
      final response = await _dio.post(
        url,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Failed to login: ${e.response?.statusCode} ${e.response?.data}');
        throw Failure(message: e.response?.data['message']);
      } else {
        print('Failed to login: ${e.message}');
        throw Failure(message: e.message.toString());
      }
    }
  }
}
