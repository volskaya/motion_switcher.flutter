import 'package:app/utils/locate.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Call this variable like `final auth = locate<AuthService>();` to
/// get your singletons.
final locate = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  asExtension: false,
)
void configureDependencies() => init(locate);
