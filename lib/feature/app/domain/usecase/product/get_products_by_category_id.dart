import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductByCategoryId
    implements UseCase<List<ProductEntity>, GetProductByCategoryIdParams> {
  final ProductRepository productRepository;

  GetProductByCategoryId(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      GetProductByCategoryIdParams params) {
    return productRepository.getProductsByCategory(params.categoryId);
  }
}

class GetProductByCategoryIdParams {
  final int categoryId;

  GetProductByCategoryIdParams({required this.categoryId});
}
