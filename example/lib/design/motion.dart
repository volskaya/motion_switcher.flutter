import 'package:flutter/widgets.dart';

class Motion {
  static const curves = _Easing();
  static const durations = _Durations();
}

class _Easing {
  const _Easing();

  final emphasized = Curves.easeInOutCubicEmphasized;
  final emphasizedDecelerate = const Cubic(0.05, 0.7, 0.1, 1.0);
  final emphasizedAccelerate = const Cubic(0.3, 0.0, 0.8, 0.15);
}

class _Durations {
  const _Durations();

  final fast = const Duration(milliseconds: 200);
  final medium = const Duration(milliseconds: 500);
  final slow = const Duration(milliseconds: 1000);
}
