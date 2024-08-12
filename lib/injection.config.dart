// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'feature/app/data/datasource/category_remote_data_source.dart' as _i7;
import 'feature/app/data/datasource/product_remote_data_source.dart' as _i6;
import 'feature/app/data/repositories/category_repository_impl.dart' as _i10;
import 'feature/app/data/repositories/product_repository_impl.dart' as _i12;
import 'feature/app/domain/repositories/category_repository.dart' as _i9;
import 'feature/app/domain/repositories/product_repository.dart' as _i11;
import 'feature/app/domain/usecase/category/get_all_categories.dart' as _i13;
import 'feature/app/domain/usecase/product/get_products_by_category_id.dart'
    as _i14;
import 'feature/app/presentation/page/home/bloc/home_bloc.dart' as _i16;
import 'feature/auth/data/auth_repository_impl.dart' as _i5;
import 'feature/auth/data/datasource/auth_remote_data_source.dart' as _i3;
import 'feature/auth/domain/repository/auth_repository.dart' as _i4;
import 'feature/auth/domain/usecase/login.dart' as _i8;
import 'feature/auth/presentation/bloc/auth_bloc.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthRemoteDataSource>(
        () => _i3.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i4.AuthRepository>(
        () => _i5.AuthRepositoryImpl(gh<_i3.AuthRemoteDataSource>()));
    gh.lazySingleton<_i6.ProductRemoteDataSource>(
        () => _i6.ProductRemoteDataSourceImpl());
    gh.lazySingleton<_i7.CategoryRemoteDataSource>(
        () => _i7.CategoryRemoteDataSourceImpl());
    gh.factory<_i8.Login>(() => _i8.Login(gh<_i4.AuthRepository>()));
    gh.lazySingleton<_i9.CategoryRepository>(
        () => _i10.CategoryRepositoryImpl(gh<_i7.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i11.ProductRepository>(
        () => _i12.ProductRepositoryImpl(gh<_i6.ProductRemoteDataSource>()));
    gh.factory<_i13.GetAllCategories>(
        () => _i13.GetAllCategories(gh<_i9.CategoryRepository>()));
    gh.factory<_i14.GetProductByCategoryId>(
        () => _i14.GetProductByCategoryId(gh<_i11.ProductRepository>()));
    gh.factory<_i15.AuthBloc>(() => _i15.AuthBloc(gh<_i8.Login>()));
    gh.factory<_i16.HomeBloc>(() => _i16.HomeBloc(
          gh<_i13.GetAllCategories>(),
          gh<_i14.GetProductByCategoryId>(),
        ));
    return this;
  }
}
