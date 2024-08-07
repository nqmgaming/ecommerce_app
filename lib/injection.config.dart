// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'feature/auth/data/auth_repository_impl.dart' as _i5;
import 'feature/auth/data/datasource/auth_remote_data_source.dart' as _i3;
import 'feature/auth/domain/repository/auth_repository.dart' as _i4;
import 'feature/auth/domain/usecase/login.dart' as _i6;
import 'feature/auth/presentation/bloc/auth_bloc.dart' as _i7;

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
    gh.factory<_i6.Login>(() => _i6.Login(gh<_i4.AuthRepository>()));
    gh.factory<_i7.AuthBloc>(() => _i7.AuthBloc(gh<_i6.Login>()));
    return this;
  }
}
