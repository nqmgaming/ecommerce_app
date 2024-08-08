import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/app/data/datasource/category_remote_data_source.dart';
import 'package:ecommerce_app/feature/app/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/app/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _categoryRemoteDataSource;

  CategoryRepositoryImpl(this._categoryRemoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      print('CategoryRepositoryImpl.getCategories');
      final categories = await _categoryRemoteDataSource.getCategories();
      print(categories);
      return Right(categories);
    } on Failure catch (e) {
      print(e);
      return Left(e);
    }
  }
}
