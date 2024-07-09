import 'package:flutter_hooks/flutter_hooks.dart';

void _constantBlankFunc() {}

extension HookStateExt<R, T extends Hook<R>> on HookState<R, T> {
  // ignore: invalid_use_of_protected_member
  void markNeedsBuild() => setState(_constantBlankFunc);
}
