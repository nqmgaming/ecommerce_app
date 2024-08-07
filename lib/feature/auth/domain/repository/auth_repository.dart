import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
}
