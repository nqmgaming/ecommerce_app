import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCartById implements UseCase<bool, DeleteCartByIdParams> {
  final CartRepository cartRepository;

  DeleteCartById(this.cartRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteCartByIdParams params) {
    return cartRepository.deleteCart(params.id);
  }
}

class DeleteCartByIdParams {
  final String id;

  DeleteCartByIdParams(
    this.id,
  );
}
