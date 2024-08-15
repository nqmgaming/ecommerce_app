import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAllCart implements UseCase<bool, DeleteAllCartParams> {
  final CartRepository cartRepository;

  DeleteAllCart(this.cartRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteAllCartParams params) {
    return cartRepository.deleteAllCart(params.userId);
  }
}

class DeleteAllCartParams {
  final String userId;

  DeleteAllCartParams(
    this.userId,
  );
}
