import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategories implements UseCase<List<CategoryEntity>, NoParams> {
  final CategoryRepository categoryRepository;

  GetAllCategories(this.categoryRepository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) {
    return categoryRepository.getCategories();
  }
}
