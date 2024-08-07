import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final user = await _authRemoteDataSource.login(email, password);
      return Right(user);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
