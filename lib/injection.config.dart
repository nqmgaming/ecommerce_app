// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/bloc/app_bloc.dart' as _i3;
import 'core/utils/user_session.dart' as _i4;
import 'feature/app/data/datasource/local/database.dart' as _i5;
import 'feature/app/data/datasource/remote/category_remote_data_source.dart'
    as _i19;
import 'feature/app/data/datasource/remote/product_remote_data_source.dart'
    as _i8;
import 'feature/app/data/repositories/cart_repository_impl.dart' as _i7;
import 'feature/app/data/repositories/category_repository_impl.dart' as _i27;
import 'feature/app/data/repositories/notification_repository_impl.dart'
    as _i22;
import 'feature/app/data/repositories/product_repository_impl.dart' as _i18;
import 'feature/app/domain/repositories/cart_repository.dart' as _i6;
import 'feature/app/domain/repositories/category_repository.dart' as _i26;
import 'feature/app/domain/repositories/notification_repository.dart' as _i21;
import 'feature/app/domain/repositories/product_repository.dart' as _i17;
import 'feature/app/domain/usecase/cart/add_to_cart.dart' as _i14;
import 'feature/app/domain/usecase/cart/delete_all_cart.dart' as _i12;
import 'feature/app/domain/usecase/cart/delete_cart_by_id.dart' as _i16;
import 'feature/app/domain/usecase/cart/get_all_cart.dart' as _i15;
import 'feature/app/domain/usecase/cart/update_cart_quantity.dart' as _i13;
import 'feature/app/domain/usecase/category/get_all_categories.dart' as _i28;
import 'feature/app/domain/usecase/notification/add_notification.dart' as _i31;
import 'feature/app/domain/usecase/notification/delete_notification.dart'
    as _i30;
import 'feature/app/domain/usecase/notification/get_all_notification_by_user_id.dart'
    as _i29;
import 'feature/app/domain/usecase/notification/read_notification.dart' as _i32;
import 'feature/app/domain/usecase/product/get_products_by_category_id.dart'
    as _i20;
import 'feature/app/presentation/page/cart/bloc/cart_bloc.dart' as _i23;
import 'feature/app/presentation/page/home/bloc/home_bloc.dart' as _i34;
import 'feature/app/presentation/page/notification/bloc/notification_bloc.dart'
    as _i35;
import 'feature/auth/data/auth_repository_impl.dart' as _i11;
import 'feature/auth/data/datasource/auth_remote_data_source.dart' as _i9;
import 'feature/auth/domain/repository/auth_repository.dart' as _i10;
import 'feature/auth/domain/usecase/get_user_info.dart' as _i25;
import 'feature/auth/domain/usecase/login.dart' as _i24;
import 'feature/auth/presentation/bloc/auth_bloc.dart' as _i33;

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
    gh.factory<_i3.AppBloc>(() => _i3.AppBloc());
    gh.lazySingleton<_i4.UserSession>(() => _i4.UserSession());
    gh.lazySingleton<_i5.AppDatabase>(() => _i5.AppDatabase());
    gh.lazySingleton<_i6.CartRepository>(
        () => _i7.CartRepositoryImpl(appDatabase: gh<_i5.AppDatabase>()));
    gh.lazySingleton<_i8.ProductRemoteDataSource>(
        () => _i8.ProductRemoteDataSourceImpl());
    gh.lazySingleton<_i9.AuthRemoteDataSource>(
        () => _i9.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i10.AuthRepository>(
        () => _i11.AuthRepositoryImpl(gh<_i9.AuthRemoteDataSource>()));
    gh.factory<_i12.DeleteAllCart>(
        () => _i12.DeleteAllCart(gh<_i6.CartRepository>()));
    gh.factory<_i13.UpdateCartQuantity>(
        () => _i13.UpdateCartQuantity(gh<_i6.CartRepository>()));
    gh.factory<_i14.AddToCart>(() => _i14.AddToCart(gh<_i6.CartRepository>()));
    gh.factory<_i15.GetAllCartByUserId>(
        () => _i15.GetAllCartByUserId(gh<_i6.CartRepository>()));
    gh.factory<_i16.DeleteCartById>(
        () => _i16.DeleteCartById(gh<_i6.CartRepository>()));
    gh.lazySingleton<_i17.ProductRepository>(
        () => _i18.ProductRepositoryImpl(gh<_i8.ProductRemoteDataSource>()));
    gh.lazySingleton<_i19.CategoryRemoteDataSource>(
        () => _i19.CategoryRemoteDataSourceImpl());
    gh.factory<_i20.GetProductByCategoryId>(
        () => _i20.GetProductByCategoryId(gh<_i17.ProductRepository>()));
    gh.lazySingleton<_i21.NotificationRepository>(
        () => _i22.NotificationRepositoryImpl(gh<_i5.AppDatabase>()));
    gh.factory<_i23.CartBloc>(() => _i23.CartBloc(
          gh<_i14.AddToCart>(),
          gh<_i12.DeleteAllCart>(),
          gh<_i16.DeleteCartById>(),
          gh<_i15.GetAllCartByUserId>(),
          gh<_i13.UpdateCartQuantity>(),
        ));
    gh.factory<_i24.Login>(() => _i24.Login(gh<_i10.AuthRepository>()));
    gh.factory<_i25.GetUserInfo>(
        () => _i25.GetUserInfo(gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i26.CategoryRepository>(
        () => _i27.CategoryRepositoryImpl(gh<_i19.CategoryRemoteDataSource>()));
    gh.factory<_i28.GetAllCategories>(
        () => _i28.GetAllCategories(gh<_i26.CategoryRepository>()));
    gh.factory<_i29.GetAllNotificationByUserId>(() =>
        _i29.GetAllNotificationByUserId(gh<_i21.NotificationRepository>()));
    gh.factory<_i30.DeleteNotification>(
        () => _i30.DeleteNotification(gh<_i21.NotificationRepository>()));
    gh.factory<_i31.AddNotification>(
        () => _i31.AddNotification(gh<_i21.NotificationRepository>()));
    gh.factory<_i32.ReadNotification>(
        () => _i32.ReadNotification(gh<_i21.NotificationRepository>()));
    gh.factory<_i33.AuthBloc>(() => _i33.AuthBloc(
          gh<_i24.Login>(),
          gh<_i25.GetUserInfo>(),
        ));
    gh.factory<_i34.HomeBloc>(() => _i34.HomeBloc(
          gh<_i28.GetAllCategories>(),
          gh<_i20.GetProductByCategoryId>(),
        ));
    gh.factory<_i35.NotificationBloc>(() => _i35.NotificationBloc(
          gh<_i31.AddNotification>(),
          gh<_i29.GetAllNotificationByUserId>(),
          gh<_i21.NotificationRepository>(),
          gh<_i4.UserSession>(),
          gh<_i32.ReadNotification>(),
          gh<_i30.DeleteNotification>(),
        ));
    return this;
  }
}
