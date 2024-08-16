import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCart implements UseCase<CartEntity, AddToCartParams> {
  final CartRepository cartRepository;

  AddToCart(this.cartRepository);

  @override
  Future<Either<Failure, CartEntity>> call(AddToCartParams params) async {
    return cartRepository.addCart(params.cart);
  }
}

class AddToCartParams {
  final CartEntity cart;

  AddToCartParams(this.cart);
}

