import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// This builder allows passing in an external opacity override.
class MotionImageOpacityBuilder extends StatefulWidget {
  const MotionImageOpacityBuilder({
    super.key,
    required this.builder,
    this.transition,
    this.opacityOverride,
  });

  final Animation<double>? transition;
  final Animation<double>? opacityOverride;
  final Widget Function(BuildContext context, Animation<double> opacity) builder;

  @override
  MotionImageOpacityBuilderState createState() => MotionImageOpacityBuilderState();
}

class MotionImageOpacityBuilderState extends State<MotionImageOpacityBuilder> {
  late _OpacityAnimation _animation;

  void _handleAnimationChange() {
    _animation = _OpacityAnimation(
      transition: widget.transition,
      opacityOverride: widget.opacityOverride,
    );
  }

  @override
  void initState() {
    _handleAnimationChange();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MotionImageOpacityBuilder oldWidget) {
    final changedTransition = oldWidget.transition != widget.transition;
    final changedOpacityOverride = oldWidget.opacityOverride != widget.opacityOverride;

    if (changedTransition != changedOpacityOverride) {
      _handleAnimationChange();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.transition?.removeListener(markNeedsBuild);
    widget.opacityOverride?.removeListener(markNeedsBuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _animation);
}

/// A single animation for [MotionImageOpacityBuilder] to pass down
/// to [RawImage].
///
/// There are some similarities with [CompoundAnimation].
class _OpacityAnimation extends Animation<double>
    with AnimationLazyListenerMixin, AnimationLocalListenersMixin, AnimationLocalStatusListenersMixin {
  _OpacityAnimation({
    this.transition,
    this.opacityOverride,
  });

  final Animation<double>? transition;
  final Animation<double>? opacityOverride;

  @override
  double get value {
    final value = transition?.value ?? 1.0;
    final transitionOpacity = opacityOverride != null ? math.min(opacityOverride!.value, value) : value;

    return transitionOpacity;
  }

  /// Gets the status of this animation based on the [transition] and [override?] status.
  ///
  /// The default is that if the [override] animation is moving, use its status.
  /// Otherwise, default to [transition].
  @override
  AnimationStatus get status {
    if (opacityOverride?.status == AnimationStatus.forward || opacityOverride?.status == AnimationStatus.reverse) {
      return opacityOverride!.status;
    }
    return transition?.status ?? AnimationStatus.completed;
  }

  @override
  String toString() {
    return '${objectRuntimeType(this, 'CompoundAnimation')}($transition, $override?)';
  }

  AnimationStatus? _lastStatus;
  void _maybeNotifyStatusListeners(AnimationStatus _) {
    if (status != _lastStatus) {
      _lastStatus = status;
      notifyStatusListeners(status);
    }
  }

  double? _lastValue;
  void _maybeNotifyListeners() {
    if (value != _lastValue) {
      _lastValue = value;
      notifyListeners();
    }
  }

  @override
  void didStartListening() {
    transition?.addListener(_maybeNotifyListeners);
    transition?.addStatusListener(_maybeNotifyStatusListeners);
    opacityOverride?.addListener(_maybeNotifyListeners);
    opacityOverride?.addStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  void didStopListening() {
    transition?.removeListener(_maybeNotifyListeners);
    transition?.removeStatusListener(_maybeNotifyStatusListeners);
    opacityOverride?.removeListener(_maybeNotifyListeners);
    opacityOverride?.removeStatusListener(_maybeNotifyStatusListeners);
  }
}

extension _StateExtension<T extends StatefulWidget> on State<T> {
  void markNeedsBuild() => setState(() {}); // ignore: invalid_use_of_protected_member
}
