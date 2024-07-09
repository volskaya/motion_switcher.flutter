import 'package:flutter/widgets.dart';
import 'package:motion_switcher/src/motion_view_indicator.dart';
import 'package:motion_switcher/src/motion_view_indicator_props.dart';

/// [MotionViewAnimatedIndicator] that creates animation for [MotionViewIndicator].
class MotionViewAnimatedIndicator extends ImplicitlyAnimatedWidget {
  const MotionViewAnimatedIndicator({
    super.key,
    super.curve = Curves.easeInOutQuart,
    required super.duration,
    required this.page,
    required this.count,
    required this.props,
    this.axis = Axis.horizontal,
  });

  final Axis axis;
  final int page;
  final int count;
  final MotionViewIndicatorProps props;

  @override
  ImplicitlyAnimatedWidgetState<MotionViewAnimatedIndicator> createState() => _MotionViewAnimatedIndicatorState();
}

class _MotionViewAnimatedIndicatorState extends ImplicitlyAnimatedWidgetState<MotionViewAnimatedIndicator> {
  Tween<double>? _pageTween;
  Animation<double>? _pageAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _pageTween = visitor(
      _pageTween,
      widget.page.toDouble(),
      (value) => Tween<double>(begin: value),
    ) as Tween<double>;
  }

  @override
  void didUpdateTweens() {
    _pageAnimation = _pageTween!.animate(animation);
    super.didUpdateTweens();
  }

  @override
  Widget build(BuildContext context) => MotionViewIndicator(
        animation: _pageAnimation!,
        count: widget.count,
        props: widget.props,
        axis: widget.axis,
      );
}
