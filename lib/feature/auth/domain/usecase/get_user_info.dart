import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserInfo implements UseCase<UserEntity, GetUserInfoParam> {
  final AuthRepository _authRepository;

  GetUserInfo(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(GetUserInfoParam params) {
    return _authRepository.getUserWithSession(params.session);
  }
}

class GetUserInfoParam {
  final String session;

  GetUserInfoParam({required this.session});
}
