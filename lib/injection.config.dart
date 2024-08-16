// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/utils/user_session.dart' as _i3;
import 'feature/app/data/datasource/local/database.dart' as _i4;
import 'feature/app/data/datasource/remote/category_remote_data_source.dart'
    as _i18;
import 'feature/app/data/datasource/remote/product_remote_data_source.dart'
    as _i7;
import 'feature/app/data/repositories/cart_repository_impl.dart' as _i6;
import 'feature/app/data/repositories/category_repository_impl.dart' as _i26;
import 'feature/app/data/repositories/notification_repository_impl.dart'
    as _i21;
import 'feature/app/data/repositories/product_repository_impl.dart' as _i17;
import 'feature/app/domain/repositories/cart_repository.dart' as _i5;
import 'feature/app/domain/repositories/category_repository.dart' as _i25;
import 'feature/app/domain/repositories/notification_repository.dart' as _i20;
import 'feature/app/domain/repositories/product_repository.dart' as _i16;
import 'feature/app/domain/usecase/cart/add_to_cart.dart' as _i13;
import 'feature/app/domain/usecase/cart/delete_all_cart.dart' as _i11;
import 'feature/app/domain/usecase/cart/delete_cart_by_id.dart' as _i15;
import 'feature/app/domain/usecase/cart/get_all_cart.dart' as _i14;
import 'feature/app/domain/usecase/cart/update_cart_quantity.dart' as _i12;
import 'feature/app/domain/usecase/category/get_all_categories.dart' as _i27;
import 'feature/app/domain/usecase/notification/add_notification.dart' as _i30;
import 'feature/app/domain/usecase/notification/delete_notification.dart'
    as _i29;
import 'feature/app/domain/usecase/notification/get_all_notification_by_user_id.dart'
    as _i28;
import 'feature/app/domain/usecase/notification/read_notification.dart' as _i31;
import 'feature/app/domain/usecase/product/get_products_by_category_id.dart'
    as _i19;
import 'feature/app/presentation/page/cart/bloc/cart_bloc.dart' as _i22;
import 'feature/app/presentation/page/home/bloc/home_bloc.dart' as _i33;
import 'feature/app/presentation/page/notification/bloc/notification_bloc.dart'
    as _i34;
import 'feature/auth/data/auth_repository_impl.dart' as _i10;
import 'feature/auth/data/datasource/auth_remote_data_source.dart' as _i8;
import 'feature/auth/domain/repository/auth_repository.dart' as _i9;
import 'feature/auth/domain/usecase/get_user_info.dart' as _i24;
import 'feature/auth/domain/usecase/login.dart' as _i23;
import 'feature/auth/presentation/bloc/auth_bloc.dart' as _i32;

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
    gh.lazySingleton<_i3.UserSession>(() => _i3.UserSession());
    gh.lazySingleton<_i4.AppDatabase>(() => _i4.AppDatabase());
    gh.lazySingleton<_i5.CartRepository>(
        () => _i6.CartRepositoryImpl(appDatabase: gh<_i4.AppDatabase>()));
    gh.lazySingleton<_i7.ProductRemoteDataSource>(
        () => _i7.ProductRemoteDataSourceImpl());
    gh.lazySingleton<_i8.AuthRemoteDataSource>(
        () => _i8.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i9.AuthRepository>(
        () => _i10.AuthRepositoryImpl(gh<_i8.AuthRemoteDataSource>()));
    gh.factory<_i11.DeleteAllCart>(
        () => _i11.DeleteAllCart(gh<_i5.CartRepository>()));
    gh.factory<_i12.UpdateCartQuantity>(
        () => _i12.UpdateCartQuantity(gh<_i5.CartRepository>()));
    gh.factory<_i13.AddToCart>(() => _i13.AddToCart(gh<_i5.CartRepository>()));
    gh.factory<_i14.GetAllCartByUserId>(
        () => _i14.GetAllCartByUserId(gh<_i5.CartRepository>()));
    gh.factory<_i15.DeleteCartById>(
        () => _i15.DeleteCartById(gh<_i5.CartRepository>()));
    gh.lazySingleton<_i16.ProductRepository>(
        () => _i17.ProductRepositoryImpl(gh<_i7.ProductRemoteDataSource>()));
    gh.lazySingleton<_i18.CategoryRemoteDataSource>(
        () => _i18.CategoryRemoteDataSourceImpl());
    gh.factory<_i19.GetProductByCategoryId>(
        () => _i19.GetProductByCategoryId(gh<_i16.ProductRepository>()));
    gh.lazySingleton<_i20.NotificationRepository>(
        () => _i21.NotificationRepositoryImpl(gh<_i4.AppDatabase>()));
    gh.factory<_i22.CartBloc>(() => _i22.CartBloc(
          gh<_i13.AddToCart>(),
          gh<_i11.DeleteAllCart>(),
          gh<_i15.DeleteCartById>(),
          gh<_i14.GetAllCartByUserId>(),
          gh<_i12.UpdateCartQuantity>(),
        ));
    gh.factory<_i23.Login>(() => _i23.Login(gh<_i9.AuthRepository>()));
    gh.factory<_i24.GetUserInfo>(
        () => _i24.GetUserInfo(gh<_i9.AuthRepository>()));
    gh.lazySingleton<_i25.CategoryRepository>(
        () => _i26.CategoryRepositoryImpl(gh<_i18.CategoryRemoteDataSource>()));
    gh.factory<_i27.GetAllCategories>(
        () => _i27.GetAllCategories(gh<_i25.CategoryRepository>()));
    gh.factory<_i28.GetAllNotificationByUserId>(() =>
        _i28.GetAllNotificationByUserId(gh<_i20.NotificationRepository>()));
    gh.factory<_i29.DeleteNotification>(
        () => _i29.DeleteNotification(gh<_i20.NotificationRepository>()));
    gh.factory<_i30.AddNotification>(
        () => _i30.AddNotification(gh<_i20.NotificationRepository>()));
    gh.factory<_i31.ReadNotification>(
        () => _i31.ReadNotification(gh<_i20.NotificationRepository>()));
    gh.factory<_i32.AuthBloc>(() => _i32.AuthBloc(
          gh<_i23.Login>(),
          gh<_i24.GetUserInfo>(),
        ));
    gh.factory<_i33.HomeBloc>(() => _i33.HomeBloc(
          gh<_i27.GetAllCategories>(),
          gh<_i19.GetProductByCategoryId>(),
        ));
    gh.factory<_i34.NotificationBloc>(() => _i34.NotificationBloc(
          gh<_i30.AddNotification>(),
          gh<_i28.GetAllNotificationByUserId>(),
          gh<_i20.NotificationRepository>(),
          gh<_i3.UserSession>(),
          gh<_i31.ReadNotification>(),
          gh<_i29.DeleteNotification>(),
        ));
    return this;
  }
}
