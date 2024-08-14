// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'feature/app/data/datasource/local/database.dart' as _i3;
import 'feature/app/data/datasource/remote/category_remote_data_source.dart'
    as _i16;
import 'feature/app/data/datasource/remote/product_remote_data_source.dart'
    as _i6;
import 'feature/app/data/repositories/cart_repository_impl.dart' as _i5;
import 'feature/app/data/repositories/category_repository_impl.dart' as _i22;
import 'feature/app/data/repositories/product_repository_impl.dart' as _i15;
import 'feature/app/domain/repositories/cart_repository.dart' as _i4;
import 'feature/app/domain/repositories/category_repository.dart' as _i21;
import 'feature/app/domain/repositories/product_repository.dart' as _i14;
import 'feature/app/domain/usecase/cart/add_to_cart.dart' as _i10;
import 'feature/app/domain/usecase/cart/delete_cart_by_id.dart' as _i13;
import 'feature/app/domain/usecase/cart/get_all_cart.dart' as _i11;
import 'feature/app/domain/usecase/cart/update_cart_quantity.dart' as _i12;
import 'feature/app/domain/usecase/category/get_all_categories.dart' as _i23;
import 'feature/app/domain/usecase/product/get_products_by_category_id.dart'
    as _i18;
import 'feature/app/presentation/page/cart/bloc/cart_bloc.dart' as _i17;
import 'feature/app/presentation/page/home/bloc/home_bloc.dart' as _i25;
import 'feature/auth/data/auth_repository_impl.dart' as _i9;
import 'feature/auth/data/datasource/auth_remote_data_source.dart' as _i7;
import 'feature/auth/domain/repository/auth_repository.dart' as _i8;
import 'feature/auth/domain/usecase/get_user_info.dart' as _i20;
import 'feature/auth/domain/usecase/login.dart' as _i19;
import 'feature/auth/presentation/bloc/auth_bloc.dart' as _i24;

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
    gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
    gh.lazySingleton<_i4.CartRepository>(
        () => _i5.CartRepositoryImpl(appDatabase: gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i6.ProductRemoteDataSource>(
        () => _i6.ProductRemoteDataSourceImpl());
    gh.lazySingleton<_i7.AuthRemoteDataSource>(
        () => _i7.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i8.AuthRepository>(
        () => _i9.AuthRepositoryImpl(gh<_i7.AuthRemoteDataSource>()));
    gh.factory<_i10.AddToCart>(() => _i10.AddToCart(gh<_i4.CartRepository>()));
    gh.factory<_i11.GetAllCartByUserId>(
        () => _i11.GetAllCartByUserId(gh<_i4.CartRepository>()));
    gh.factory<_i12.UpdateCartQuantity>(
        () => _i12.UpdateCartQuantity(gh<_i4.CartRepository>()));
    gh.factory<_i13.DeleteCartById>(
        () => _i13.DeleteCartById(gh<_i4.CartRepository>()));
    gh.lazySingleton<_i14.ProductRepository>(
        () => _i15.ProductRepositoryImpl(gh<_i6.ProductRemoteDataSource>()));
    gh.lazySingleton<_i16.CategoryRemoteDataSource>(
        () => _i16.CategoryRemoteDataSourceImpl());
    gh.factory<_i17.CartBloc>(() => _i17.CartBloc(
          gh<_i10.AddToCart>(),
          gh<_i11.GetAllCartByUserId>(),
          gh<_i12.UpdateCartQuantity>(),
          gh<_i13.DeleteCartById>(),
        ));
    gh.factory<_i18.GetProductByCategoryId>(
        () => _i18.GetProductByCategoryId(gh<_i14.ProductRepository>()));
    gh.factory<_i19.Login>(() => _i19.Login(gh<_i8.AuthRepository>()));
    gh.factory<_i20.GetUserInfo>(
        () => _i20.GetUserInfo(gh<_i8.AuthRepository>()));
    gh.lazySingleton<_i21.CategoryRepository>(
        () => _i22.CategoryRepositoryImpl(gh<_i16.CategoryRemoteDataSource>()));
    gh.factory<_i23.GetAllCategories>(
        () => _i23.GetAllCategories(gh<_i21.CategoryRepository>()));
    gh.factory<_i24.AuthBloc>(() => _i24.AuthBloc(
          gh<_i19.Login>(),
          gh<_i20.GetUserInfo>(),
        ));
    gh.factory<_i25.HomeBloc>(() => _i25.HomeBloc(
          gh<_i23.GetAllCategories>(),
          gh<_i18.GetProductByCategoryId>(),
        ));
    return this;
  }
}
