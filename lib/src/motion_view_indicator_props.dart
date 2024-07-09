import 'package:flutter/widgets.dart';

/// Sealed class for one of our props.
///
/// - [MotionViewIndicatorPropsWarm] - Where the active pin animates in width.
/// - [MotionViewIndicatorPropsWide] - Where the active pin animates in width, spanning all available layout.
/// - [MotionViewIndicatorPropsScale] - Where the active pin animates in scale.
sealed class MotionViewIndicatorProps {
  const MotionViewIndicatorProps({
    required this.color,
    required this.activeColor,
  });

  final Color color;
  final Color activeColor;
}

class MotionViewIndicatorPropsWarm extends MotionViewIndicatorProps {
  const MotionViewIndicatorPropsWarm({
    required super.color,
    required super.activeColor,
  });
}

class MotionViewIndicatorPropsScale extends MotionViewIndicatorProps {
  const MotionViewIndicatorPropsScale({
    required super.color,
    required super.activeColor,
    required this.scale,
  });

  /// Scale when the indicator is active.
  final double scale;
}

class MotionViewIndicatorPropsWide extends MotionViewIndicatorProps {
  const MotionViewIndicatorPropsWide({
    required super.color,
    required super.activeColor,
    this.borderRadius,
  });

  final BorderRadius? borderRadius;
}
