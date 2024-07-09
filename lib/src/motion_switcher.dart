import 'dart:async';

import 'package:await_route/await_route.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' hide Stack;
import 'package:motion_switcher/src/widgets/stack.dart';
import 'package:other_animations/other_animations.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Type of the animation used in the switcher widgets.
enum MotionSwitcherType {
  fade,
  axisVertical,
  axisHorizontal,
  scaled,
}

class _ChildEntry {
  /// If the widget is a [MotionSwitcherTag] and its tag is an int,
  /// it's assumed as an index to support reverse switches.
  ///
  /// Also unwrap [MotionSwitcherTag]'s child.
  factory _ChildEntry.fromWidget(Widget widget) => _ChildEntry._(
        widget is MotionSwitcherTag ? widget.child : widget,
        MotionSwitcherTag.getKey(widget),
        MotionSwitcherTag.getIndex(widget),
      );

  _ChildEntry._(this.widget, this.key, this.index);

  final Widget widget;
  final Key? key;
  final int? index;
}

/// Switcher widget that animates children with page like transitions.
///
/// Control forward / reverse motion by wrapping the child widgts in [MotionSwitcherTag].
class MotionSwitcher extends StatefulWidget {
  /// Creates a [MotionSwitcher] with the fade transition.
  const MotionSwitcher({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 250),
    this.delay = Duration.zero,
    this.shouldDelay,
    this.onEnd,
    this.onStatusChanged,
    this.placeholder,
    this.addRepaintBoundary = false,
    this.wrapChildrenInRepaintBoundary = false,
    this.awaitRoute = false,
    this.fillColor = const Color(0x00000000),
    this.sliver = false,
    this.reverse = true,
    this.delayInitialChild = true,
    this.instantSize = false,
  })  : _type = MotionSwitcherType.fade,
        assert(placeholder == null || placeholder is! MotionSwitcherTag);

  /// Creates a [MotionSwitcher] with the vertical axis transition.
  const MotionSwitcher.vertical({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 250),
    this.delay = Duration.zero,
    this.shouldDelay,
    this.onEnd,
    this.onStatusChanged,
    this.placeholder,
    this.addRepaintBoundary = false,
    this.wrapChildrenInRepaintBoundary = false,
    this.awaitRoute = false,
    this.fillColor = const Color(0x00000000),
    this.sliver = false,
    this.reverse = true,
    this.delayInitialChild = true,
    this.instantSize = false,
  })  : _type = MotionSwitcherType.axisVertical,
        assert(placeholder == null || placeholder is! MotionSwitcherTag);

  /// Creates a [MotionSwitcher] with the horizontal axis transition.
  const MotionSwitcher.horizontal({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 250),
    this.delay = Duration.zero,
    this.shouldDelay,
    this.onEnd,
    this.onStatusChanged,
    this.placeholder,
    this.addRepaintBoundary = false,
    this.wrapChildrenInRepaintBoundary = false,
    this.awaitRoute = false,
    this.fillColor = const Color(0x00000000),
    this.sliver = false,
    this.reverse = true,
    this.delayInitialChild = true,
    this.instantSize = false,
  })  : _type = MotionSwitcherType.axisHorizontal,
        assert(placeholder == null || placeholder is! MotionSwitcherTag);

  /// Creates a [MotionSwitcher] with the scale transition;
  const MotionSwitcher.scaled({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 250),
    this.delay = Duration.zero,
    this.shouldDelay,
    this.onEnd,
    this.onStatusChanged,
    this.placeholder,
    this.addRepaintBoundary = false,
    this.wrapChildrenInRepaintBoundary = false,
    this.awaitRoute = false,
    this.fillColor = const Color(0x00000000),
    this.sliver = false,
    this.reverse = false,
    this.delayInitialChild = true,
    this.instantSize = false,
  })  : _type = MotionSwitcherType.scaled,
        assert(placeholder == null || placeholder is! MotionSwitcherTag);

  /// Animated child of [MotionSwitcher].
  final Widget? child;

  /// Temporary child to build when using [delay], before the real [child] is built.
  final Widget? placeholder;

  /// Box alignment of children within the animated switcher.
  final AlignmentGeometry alignment;

  /// Callback when the transation ends.
  final VoidCallback? onEnd;

  /// Callback when the animation status changes. This is called before [onEnd].
  final ValueChanged<AnimationStatus>? onStatusChanged;

  /// The duration of the switch animation.
  final Duration duration;

  /// Delay of the switch.
  final Duration delay;

  /// Optional callback to control when the switch should be delayed.
  final bool Function()? shouldDelay;

  /// The type of the switcher.
  final MotionSwitcherType _type;

  /// Wrap the transition in a [RepaintBoundary].
  final bool addRepaintBoundary;

  /// Wrap the child widgets in a [RepaintBoundary].
  final bool wrapChildrenInRepaintBoundary;

  /// Show a placeholder widget, until the route has animated in.
  final bool awaitRoute;

  /// Whether to apply [delay] to the initial child.
  final bool delayInitialChild;

  /// Fill color built into some transitions.
  ///
  /// Should usually either be transparent or match the background of the container.
  final Color fillColor;

  /// Whether to use sliver layout builder.
  ///
  /// This must be toggled, if the switcher is built within a scroll view.
  final bool sliver;

  /// Whether to allow the switcher to animate in reverse.
  ///
  /// Reverse animation would happen if the same widget got switched back or a
  /// [MotionSwitcherTag] was built with a lower index.
  final bool reverse;

  /// When `true`, the layout will size it to the last child's size, even if any
  /// other children are still animating out.
  ///
  /// This can stop widgets from painting in certain scenarios, where parents are
  /// missing necesarry constraints, so test before using.
  ///
  /// This doesn't support [sliver] layout.
  final bool instantSize;

  /// Layout builder for slivers.
  static SliverStack sliverLayoutBuilder(
    List<Widget> entries, [
    AlignmentGeometry alignment = Alignment.center,
  ]) =>
      SliverStack(positionedAlignment: alignment, children: entries);

  /// Layout builder for boxes.
  static Stack boxLayoutBuilder(
    List<Widget> entries, [
    AlignmentGeometry alignment = Alignment.center,
    StackSizeTarget sizeTarget = StackSizeTarget.expand,
  ]) =>
      Stack(
        alignment: alignment,
        clipBehavior: Clip.none,
        sizeTarget: sizeTarget,
        children: entries,
      );

  @override
  MotionSwitcherState createState() => MotionSwitcherState();
}

class MotionSwitcherState extends State<MotionSwitcher> {
  _ChildEntry? _child;
  bool _reverse = false;
  dynamic _reverseKey;
  Widget get _placeholder => widget.placeholder != null
      ? MotionSwitcherTag(tag: MotionSwitcherTag.placeholderTag, child: widget.placeholder!)
      : const MotionSwitcherTag(tag: MotionSwitcherTag.placeholderTag, child: SizedBox.shrink());

  static bool _compareChildren(Widget? a, Widget? b) => MotionSwitcherTag.canUpdate(a, b);

  // When the entries are swapped, their index is compared to determine if
  // the next switch should animate in reverse.
  void _swapChildEntries(Widget? child, {bool canUpdate = false}) {
    final entry = child != null ? _ChildEntry.fromWidget(child) : null;

    if (widget.reverse) {
      if (!canUpdate) {
        if ((entry?.index ?? 0) == (_child?.index ?? 0)) {
          // Indexes default to 0. If swapping entries with the same indexes, check if the new
          // key matches the previous child's key, to determine whether to reverse the animation.
          _reverse = entry?.key == _reverseKey;
          if (!_reverse) _reverseKey = _child?.key;
        } else if (entry?.index == null && _child?.index != null) {
          _reverse = false;
        } else {
          _reverse = (entry?.index ?? 0) < (_child?.index ?? 0) ? true : false;
        }
      }
    } else {
      _reverse = false;
      _reverseKey = null;
    }

    setState(() {
      _child = entry;
    });
  }

  Future _scheduleChild(Widget child) async {
    assert(widget.awaitRoute || widget.delay > Duration.zero);

    if (widget.awaitRoute) await AwaitRoute.of(context);
    if (mounted && widget.delay > Duration.zero && (widget.shouldDelay?.call() ?? true)) {
      await Future<void>.delayed(widget.delay * timeDilation);
    }
    if (mounted && _compareChildren(widget.child, child)) {
      _swapChildEntries(widget.child);
    }
  }

  void _handleChildChange(Widget? old, Widget? current, {bool isInitial = false}) {
    if (!_compareChildren(old, current) || isInitial) {
      final shouldDelay = widget.delay > Duration.zero && (widget.shouldDelay?.call() ?? true);
      final willDelay = isInitial
          ? widget.delayInitialChild
              ? shouldDelay
              : false
          : shouldDelay;

      if (willDelay || widget.awaitRoute) {
        if (isInitial) {
          _swapChildEntries(_placeholder);
          if (current != null) _scheduleChild(current);
        } else {
          _scheduleChild(current ?? _placeholder);
        }
      } else {
        _swapChildEntries(current ?? _placeholder);
      }
    } else if (old != current) {
      _swapChildEntries(current ?? _placeholder, canUpdate: true);
    }
  }

  @override
  void initState() {
    super.initState();
    if (_child == null) _handleChildChange(null, widget.child, isInitial: true);
  }

  @override
  void didUpdateWidget(covariant MotionSwitcher oldWidget) {
    _handleChildChange(oldWidget.child, widget.child);
    super.didUpdateWidget(oldWidget);
  }

  Widget _transition(
    Widget child,
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
  ) {
    switch (widget._type) {
      case MotionSwitcherType.fade:
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          onEnd: widget.onEnd,
          onStatusChanged: widget.onStatusChanged,
          fillColor: widget.fillColor,
          sliver: widget.sliver,
          child: child,
        );
      case MotionSwitcherType.axisVertical:
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          onEnd: widget.onEnd,
          onStatusChanged: widget.onStatusChanged,
          fillColor: widget.fillColor,
          sliver: widget.sliver,
          child: child,
        );
      case MotionSwitcherType.axisHorizontal:
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          onEnd: widget.onEnd,
          onStatusChanged: widget.onStatusChanged,
          fillColor: widget.fillColor,
          sliver: widget.sliver,
          child: child,
        );
      case MotionSwitcherType.scaled:
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          onEnd: widget.onEnd,
          onStatusChanged: widget.onStatusChanged,
          fillColor: widget.fillColor,
          sliver: widget.sliver,
          child: child,
        );
    }
  }

  Widget _buildLayout(
    List<Widget> entries, [
    AlignmentGeometry alignment = Alignment.center,
  ]) =>
      widget.sliver
          ? MotionSwitcher.sliverLayoutBuilder(entries, alignment)
          : MotionSwitcher.boxLayoutBuilder(
              entries,
              alignment,
              widget.instantSize
                  ? _reverse
                      ? StackSizeTarget.firstChild
                      : StackSizeTarget.lastChild
                  : StackSizeTarget.expand,
            );

  @override
  Widget build(BuildContext context) {
    assert(widget.reverse || !_reverse);

    Widget? child = _child != null
        ? !widget.sliver && widget.wrapChildrenInRepaintBoundary
            ? RepaintBoundary(key: _child!.key, child: _child!.widget)
            : KeyedSubtree(key: _child!.key, child: _child!.widget)
        : null;

    child = PageTransitionSwitcher(
      transitionBuilder: _transition,
      alignment: widget.alignment,
      duration: widget.duration,
      reverse: _reverse,
      layoutBuilder: _buildLayout,
      child: child,
    );

    if (!widget.sliver && widget.addRepaintBoundary) {
      child = RepaintBoundary(child: child);
    }

    return child;
  }
}

/// Tag widget that allows [MotionSwitcher] to differentiate the same animating widget types.
///
/// Use this to control the direction of the animation, by setting [index].
class MotionSwitcherTag extends StatelessWidget {
  /// Creates [MotionSwitcherTag].
  const MotionSwitcherTag({
    super.key,
    required this.child,
    this.tag,
    this.index,
  });

  /// Tag of the placeholder widget used in [MotionSwicher].
  static const placeholderTag = -1;

  /// The tag that's gonna be compared against another switcher child.
  final dynamic tag;

  /// Child [Widget] of this [MotionSwitcherTag].
  final Widget child;

  /// Optional index of this [MotionSwitcherTag] to allow [MotionSwitcher] to know when
  /// to run the animation in reverse.
  ///
  /// If this is null and the [tag] is an int, the tag is used as the index instead.
  ///
  /// You should only use [index] if you don't want the [MotionSwitcher] to switch based on the index.
  final int? index;

  /// Attempts to extract [MotionSwitcherTag] tag as a [ValueKey] from the [child].
  /// If the child is not a [MotionSwitcherTag], default to it's own key or runtime key.
  static Key? getKey(Widget? child) => child != null
      ? (child is MotionSwitcherTag && child.tag != null)
          ? ValueKey<dynamic>(child.tag)
          : (child.key ?? ValueKey(child.runtimeType))
      : null;

  /// Vairant of [Widget.canUpdate] that also factors in [MotionSwitcherTag]'s props.
  static bool canUpdate(Widget? a, Widget? b) {
    final dynamic aTag = a is MotionSwitcherTag ? a.tag : null;
    final dynamic bTag = b is MotionSwitcherTag ? b.tag : null;

    final dynamic aChild = a is MotionSwitcherTag ? a.child : a;
    final dynamic bChild = b is MotionSwitcherTag ? b.child : b;

    return aTag == bTag && ((aChild?.key ?? aChild?.runtimeType) == (bChild?.key ?? bChild?.runtimeType));
  }

  /// Attempt to get the dynamic tag out of [MotionSwitcherTag].
  static int? getIndex(Widget? child) => child != null && child is MotionSwitcherTag
      ? child.index ?? (child.tag != null && child.tag is int ? child.tag as int : 0)
      : null;

  @override
  Widget build(BuildContext context) {
    assert(false, 'MotionSwitcherTag is not supposed to be included in the widget tree');
    return child;
  }
}
