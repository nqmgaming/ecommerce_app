// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/utils/user_session.dart' as _i3;
import 'feature/app/data/datasource/local/database.dart' as _i4;
import 'feature/app/data/datasource/remote/category_remote_data_source.dart'
    as _i20;
import 'feature/app/data/datasource/remote/product_remote_data_source.dart'
    as _i9;
import 'feature/app/data/repositories/cart_repository_impl.dart' as _i6;
import 'feature/app/data/repositories/category_repository_impl.dart' as _i27;
import 'feature/app/data/repositories/notification_repository_impl.dart'
    as _i23;
import 'feature/app/data/repositories/product_repository_impl.dart' as _i19;
import 'feature/app/domain/repositories/cart_repository.dart' as _i5;
import 'feature/app/domain/repositories/category_repository.dart' as _i26;
import 'feature/app/domain/repositories/notification_repository.dart' as _i22;
import 'feature/app/domain/repositories/product_repository.dart' as _i18;
import 'feature/app/domain/usecase/cart/add_to_cart.dart' as _i14;
import 'feature/app/domain/usecase/cart/delete_all_cart.dart' as _i17;
import 'feature/app/domain/usecase/cart/delete_cart_by_id.dart' as _i16;
import 'feature/app/domain/usecase/cart/get_all_cart.dart' as _i15;
import 'feature/app/domain/usecase/cart/update_cart_quantity.dart' as _i13;
import 'feature/app/domain/usecase/category/get_all_categories.dart' as _i28;
import 'feature/app/domain/usecase/notification/add_notification.dart' as _i32;
import 'feature/app/domain/usecase/notification/delete_notification.dart'
    as _i31;
import 'feature/app/domain/usecase/notification/get_all_notification_by_user_id.dart'
    as _i30;
import 'feature/app/domain/usecase/notification/read_notification.dart' as _i33;
import 'feature/app/domain/usecase/product/get_products_by_category_id.dart'
    as _i21;
import 'feature/app/presentation/page/cart/bloc/cart_bloc.dart' as _i29;
import 'feature/app/presentation/page/home/bloc/home_bloc.dart' as _i35;
import 'feature/app/presentation/page/notification/bloc/notification_bloc.dart'
    as _i36;
import 'feature/app/presentation/page/profile/page/profile_page.dart' as _i7;
import 'feature/auth/data/auth_repository_impl.dart' as _i12;
import 'feature/auth/data/datasource/auth_remote_data_source.dart' as _i10;
import 'feature/auth/domain/repository/auth_repository.dart' as _i11;
import 'feature/auth/domain/usecase/get_user_info.dart' as _i25;
import 'feature/auth/domain/usecase/login.dart' as _i24;
import 'feature/auth/presentation/bloc/auth_bloc.dart' as _i34;

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
    gh.factory<_i7.ProfilePage>(() => _i7.ProfilePage(key: gh<_i8.Key>()));
    gh.lazySingleton<_i9.ProductRemoteDataSource>(
        () => _i9.ProductRemoteDataSourceImpl());
    gh.lazySingleton<_i10.AuthRemoteDataSource>(
        () => _i10.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i11.AuthRepository>(
        () => _i12.AuthRepositoryImpl(gh<_i10.AuthRemoteDataSource>()));
    gh.factory<_i13.UpdateCartQuantity>(
        () => _i13.UpdateCartQuantity(gh<_i5.CartRepository>()));
    gh.factory<_i14.AddToCart>(() => _i14.AddToCart(gh<_i5.CartRepository>()));
    gh.factory<_i15.GetAllCartByUserId>(
        () => _i15.GetAllCartByUserId(gh<_i5.CartRepository>()));
    gh.factory<_i16.DeleteCartById>(
        () => _i16.DeleteCartById(gh<_i5.CartRepository>()));
    gh.factory<_i17.DeleteAllCart>(
        () => _i17.DeleteAllCart(gh<_i5.CartRepository>()));
    gh.lazySingleton<_i18.ProductRepository>(
        () => _i19.ProductRepositoryImpl(gh<_i9.ProductRemoteDataSource>()));
    gh.lazySingleton<_i20.CategoryRemoteDataSource>(
        () => _i20.CategoryRemoteDataSourceImpl());
    gh.factory<_i21.GetProductByCategoryId>(
        () => _i21.GetProductByCategoryId(gh<_i18.ProductRepository>()));
    gh.lazySingleton<_i22.NotificationRepository>(
        () => _i23.NotificationRepositoryImpl(gh<_i4.AppDatabase>()));
    gh.factory<_i24.Login>(() => _i24.Login(gh<_i11.AuthRepository>()));
    gh.factory<_i25.GetUserInfo>(
        () => _i25.GetUserInfo(gh<_i11.AuthRepository>()));
    gh.lazySingleton<_i26.CategoryRepository>(
        () => _i27.CategoryRepositoryImpl(gh<_i20.CategoryRemoteDataSource>()));
    gh.factory<_i28.GetAllCategories>(
        () => _i28.GetAllCategories(gh<_i26.CategoryRepository>()));
    gh.factory<_i29.CartBloc>(() => _i29.CartBloc(
          gh<_i14.AddToCart>(),
          gh<_i15.GetAllCartByUserId>(),
          gh<_i13.UpdateCartQuantity>(),
          gh<_i16.DeleteCartById>(),
          gh<_i17.DeleteAllCart>(),
        ));
    gh.factory<_i30.GetAllNotificationByUserId>(() =>
        _i30.GetAllNotificationByUserId(gh<_i22.NotificationRepository>()));
    gh.factory<_i31.DeleteNotification>(
        () => _i31.DeleteNotification(gh<_i22.NotificationRepository>()));
    gh.factory<_i32.AddNotification>(
        () => _i32.AddNotification(gh<_i22.NotificationRepository>()));
    gh.factory<_i33.ReadNotification>(
        () => _i33.ReadNotification(gh<_i22.NotificationRepository>()));
    gh.factory<_i34.AuthBloc>(() => _i34.AuthBloc(
          gh<_i24.Login>(),
          gh<_i25.GetUserInfo>(),
        ));
    gh.factory<_i35.HomeBloc>(() => _i35.HomeBloc(
          gh<_i28.GetAllCategories>(),
          gh<_i21.GetProductByCategoryId>(),
        ));
    gh.factory<_i36.NotificationBloc>(() => _i36.NotificationBloc(
          gh<_i32.AddNotification>(),
          gh<_i30.GetAllNotificationByUserId>(),
          gh<_i22.NotificationRepository>(),
          gh<_i3.UserSession>(),
          gh<_i33.ReadNotification>(),
          gh<_i31.DeleteNotification>(),
        ));
    return this;
  }
}
