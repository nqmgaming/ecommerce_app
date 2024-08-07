import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Login implements UseCase<UserEntity, LoginParam> {
  final AuthRepository _authRepository;

  Login(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParam params) {
    return _authRepository.login(params.email, params.password);
  }
}

class LoginParam {
  final String email;
  final String password;

  LoginParam({required this.email, required this.password});
}
