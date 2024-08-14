import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartQuantity implements UseCase<bool, UpdateCartQuantityParams> {
  final CartRepository cartRepository;

  UpdateCartQuantity(this.cartRepository);

  @override
  Future<Either<Failure, bool>> call(UpdateCartQuantityParams params) async {
    return cartRepository.updateCart(params.id, params.quantity);
  }
}

class UpdateCartQuantityParams {
  final String id;
  final int quantity;

  UpdateCartQuantityParams(this.id, this.quantity);
}
