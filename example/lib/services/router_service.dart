import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import "router_service.gr.dart";

@lazySingleton
@AutoRouterConfig()
class RouterService extends $RouterService {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
      ];

  void reset() => replaceAll(const [HomeRoute()]);

  @override
  @disposeMethod
  void dispose() => super.dispose();
}
