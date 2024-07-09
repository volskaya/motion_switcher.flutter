import 'package:flutter/widgets.dart';

void _constantBlankFunc() {}

extension StateExt<T extends StatefulWidget> on State<T> {
  // ignore: invalid_use_of_protected_member
  void markNeedsBuild() => setState(_constantBlankFunc);
}
