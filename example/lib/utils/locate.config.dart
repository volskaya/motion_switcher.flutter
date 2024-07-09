// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/services/alert_service.dart' as _i5;
import 'package:app/services/log_service.dart' as _i3;
import 'package:app/services/router_service.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.LogService>(() => _i3.LogService());
  gh.lazySingleton<_i4.RouterService>(
    () => _i4.RouterService(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i5.AlertService>(
    () => _i5.AlertService(),
    dispose: (i) => i.close(),
  );
  return getIt;
}
