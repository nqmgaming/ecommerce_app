import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCartByUserId
    implements UseCase<List<CartEntity>, GetAllCartByUserIdParams> {
  final CartRepository cartRepository;

  GetAllCartByUserId(this.cartRepository);

  @override
  Future<Either<Failure, List<CartEntity>>> call(
      GetAllCartByUserIdParams params) {
    return cartRepository.getCartByUser(params.userId);
  }
}

class GetAllCartByUserIdParams {
  final String userId;

  GetAllCartByUserIdParams(this.userId);
}
