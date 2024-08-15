import 'package:ecommerce_app/core/constants/apps_constant.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);

  Future<UserModel> getUserWithSession(String session);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<UserModel> login(String email, String password) async {
    const url = '${AppsConstant.baseUrl}auth/login';
    try {
      final response = await _dio.post(
        url,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201) {
        final user = UserModel.fromJson(response.data);
        if (user.assetToken != null && user.refreshToken != null) {
          await _secureStorage.write(
              key: 'access_token', value: user.assetToken);
          await _secureStorage.write(
              key: 'refresh_token', value: user.refreshToken);
        } else {
          throw Exception('Tokens are null');
        }
        return user;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
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
  Future<UserModel> getUserWithSession(String session) async {
    const url = '${AppsConstant.baseUrl}auth/profile';
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $session',
          },
        ),
      );

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data);
        // Save user data to local storage
        await _secureStorage.write(
            key: 'userId', value: userModel.id.toString());
        await _secureStorage.write(key: 'email', value: userModel.email);
        await _secureStorage.write(key: 'name', value: userModel.name);
        await _secureStorage.write(key: 'avatar', value: userModel.avatar);
        await _secureStorage.write(key: 'role', value: userModel.role);
        return userModel;
      } else if (response.statusCode == 401) {
        // If unauthorized, try to refresh the token
        final newAccessToken = await _refreshAccessToken();
        if (newAccessToken != null) {
          // Retry the request with the new token
          return getUserWithSession(newAccessToken);
        } else {
          throw Exception('Failed to refresh token');
        }
      } else {
        throw Exception('Failed to get user: ${response.statusCode}');
      }
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<String?> _refreshAccessToken() async {
    const url = 'https://api.escuelajs.co/api/v1/auth/refresh-token';
    try {
      final refreshToken = await _secureStorage.read(key: 'refresh_token');
      if (refreshToken == null) {
        throw Exception('No refresh token found');
      }

      final response = await _dio.post(
        url,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        // Save the new tokens
        await _secureStorage.write(key: 'access_token', value: newAccessToken);
        await _secureStorage.write(
            key: 'refresh_token', value: newRefreshToken);

        return newAccessToken;
      } else {
        throw Exception('Failed to refresh token: ${response.statusCode}');
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
