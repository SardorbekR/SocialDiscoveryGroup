// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/states_selector/data/data_sources/states_selector_datasources.dart' as _i4;
import '../features/states_selector/domain/repositories/states_selector_repository.dart' as _i5;
import '../features/states_selector/presentation/bloc/states_selector_bloc.dart' as _i6;
import 'register_module.dart' as _i7;

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
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.Dio>(() => registerModule.dio());
    gh.factory<_i4.StatesSelectorDatasource>(
        () => _i4.StatesSelectorDatasource(dio: gh<_i3.Dio>()));
    gh.factory<_i5.StatesSelectorRepository>(
        () => _i5.StatesSelectorRepository(dataSource: gh<_i4.StatesSelectorDatasource>()));
    gh.factory<_i6.StatesSelectorBloc>(
        () => _i6.StatesSelectorBloc(repository: gh<_i5.StatesSelectorRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i7.RegisterModule {}
