// ignore_for_file:invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:motion_switcher/src/motion_switcher.dart';
import 'package:other_animations/other_animations.dart';

enum _Position { reverse, idle, forward }

enum _Direction { incoming, outgoing }

/// Item builder for [MotionView] children.
typedef MotionViewItemBuilder = Widget Function(BuildContext contex, int index);

/// Page view with transition animations, instead of linear swipe animation.
/// Similar to how pages transition in the google play app.
class MotionView extends StatelessWidget {
  /// Creates fade variant of [MotionView].
  const MotionView.fade({
    super.key,
    this.pageViewKey,
    required this.itemBuilder,
    required this.itemCount,
    this.fillColor = const Color(0x00000000),
    this.swipeDirection = Axis.horizontal,
    this.controller,
    this.addRepaintBoundaries = true,
    this.clipBehavior = Clip.hardEdge,
    this.onPageChanged,
    this.physics = const ClampingScrollPhysics(),
    this.allowImplicitScrolling = false,
    this.enableScroll = true,
    this.wantKeepAlive = false,
  }) : _type = MotionSwitcherType.fade;

  /// Creates shared axis vertical variant of [MotionView].
  const MotionView.vertical({
    super.key,
    this.pageViewKey,
    required this.itemBuilder,
    required this.itemCount,
    this.fillColor = const Color(0x00000000),
    this.controller,
    this.addRepaintBoundaries = true,
    this.clipBehavior = Clip.hardEdge,
    this.onPageChanged,
    this.physics = const ClampingScrollPhysics(),
    this.allowImplicitScrolling = false,
    this.enableScroll = true,
    this.wantKeepAlive = false,
  })  : _type = MotionSwitcherType.axisVertical,
        swipeDirection = Axis.vertical;

  /// Creates shared axis horizontal variant of [MotionView].
  const MotionView.horizontal({
    super.key,
    this.pageViewKey,
    required this.itemBuilder,
    required this.itemCount,
    this.fillColor = const Color(0x00000000),
    this.controller,
    this.addRepaintBoundaries = true,
    this.clipBehavior = Clip.hardEdge,
    this.onPageChanged,
    this.physics = const ClampingScrollPhysics(),
    this.allowImplicitScrolling = false,
    this.enableScroll = true,
    this.wantKeepAlive = false,
  })  : _type = MotionSwitcherType.axisHorizontal,
        swipeDirection = Axis.horizontal;

  /// Creates shared axis scaled variant of [MotionView].
  const MotionView.scaled({
    super.key,
    this.pageViewKey,
    required this.itemBuilder,
    required this.itemCount,
    this.fillColor = const Color(0x00000000),
    this.swipeDirection = Axis.horizontal,
    this.controller,
    this.addRepaintBoundaries = true,
    this.clipBehavior = Clip.hardEdge,
    this.onPageChanged,
    this.physics = const ClampingScrollPhysics(),
    this.allowImplicitScrolling = false,
    this.enableScroll = true,
    this.wantKeepAlive = false,
  }) : _type = MotionSwitcherType.scaled;

  /// A [key] to pass to the [PageView] we build in this widget.
  final Key? pageViewKey;

  /// Child builder.
  final MotionViewItemBuilder itemBuilder;

  /// Child widget count.
  final int itemCount;

  /// Type of the transition animation.
  final MotionSwitcherType _type;

  /// Fill color built into some transitions.
  ///
  /// Should usually either be transparent or match the background of the switchers container.
  final Color fillColor;

  /// Swipe direction of this [MotionView].
  final Axis swipeDirection;

  /// Page controller of the inner [PageView].
  final PageController? controller;

  /// Whether to wrap child widget in repaint boundaries.
  final bool addRepaintBoundaries;

  /// Clip behavior of the [PageView].
  final Clip clipBehavior;

  /// Called when the page changes.
  final ValueChanged<int>? onPageChanged;

  /// [ScrollPhysics] of the inner [PageView].
  final ScrollPhysics physics;

  /// Allow implicit scrolling on iOS. While this is enabled, the cache extent is set
  /// to 1 viewport, which means other the surrounding pages will get prebuilt.
  final bool allowImplicitScrolling;

  /// When disabled, scroll physics will fallback to [NeverScrollableScrollPhysics].
  final bool enableScroll;

  /// Whether to keep state and scroll positions alive.
  ///
  /// [MotionView] doesn't yet support [PageController.keepPage] as some animations here
  /// depend on the position being known, before the inner [PageView] has attached to
  /// the controller.
  final bool wantKeepAlive;

  Widget _transition(
    Widget child,
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
  ) {
    switch (_type) {
      case MotionSwitcherType.fade:
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: fillColor,
          child: child,
        );
      case MotionSwitcherType.axisVertical:
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          fillColor: fillColor,
          child: child,
        );
      case MotionSwitcherType.axisHorizontal:
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: fillColor,
          child: child,
        );
      case MotionSwitcherType.scaled:
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: fillColor,
          child: child,
        );
    }
  }

  @override
  Widget build(BuildContext context) => _MotionPageView(
        pageViewKey: pageViewKey,
        controller: controller,
        itemBuilder: itemBuilder,
        itemCount: itemCount,
        swipeDirection: swipeDirection,
        transitionBuilder: _transition,
        addRepaintBoundaries: addRepaintBoundaries,
        fillColor: fillColor,
        clipBehavior: clipBehavior,
        onPageChanged: onPageChanged,
        physics: physics,
        allowImplicitScrolling: allowImplicitScrolling,
        enableScroll: enableScroll,
        wantKeepAlive: wantKeepAlive,
      );
}

class _MotionPageView extends StatefulWidget {
  const _MotionPageView({
    super.key,
    this.pageViewKey,
    required this.itemBuilder,
    required this.itemCount,
    required this.transitionBuilder,
    this.swipeDirection = Axis.horizontal,
    this.fillColor = const Color(0x00000000),
    this.controller,
    this.addRepaintBoundaries = true,
    this.clipBehavior = Clip.hardEdge,
    this.onPageChanged,
    this.physics = const ClampingScrollPhysics(),
    this.allowImplicitScrolling = true,
    this.scrollBehavior,
    this.reverse = false,
    this.pageSnapping = true,
    this.enableScroll = true,
    this.wantKeepAlive = false,
  });

  final Key? pageViewKey;
  final MotionViewItemBuilder itemBuilder;
  final int itemCount;
  final Axis swipeDirection;
  final PageTransitionSwitcherTransitionBuilder transitionBuilder;
  final Color fillColor;
  final PageController? controller;
  final bool addRepaintBoundaries;
  final Clip clipBehavior;
  final ValueChanged<int>? onPageChanged;
  final ScrollPhysics physics;
  final bool allowImplicitScrolling;
  final ScrollBehavior? scrollBehavior;
  final bool reverse;
  final bool pageSnapping;
  final bool enableScroll;
  final bool wantKeepAlive;

  @override
  _MotionPageViewState createState() => _MotionPageViewState();
}

class _MotionPageViewState extends State<_MotionPageView> with AutomaticKeepAliveClientMixin {
  final _goingReverse = ValueNotifier<bool?>(null);

  late PageController _controller;
  bool _disposeController = false;
  int _lastReportedPage = 0;
  double _lastValue = 0.0;

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  void _handleChange({double? value}) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _value = value ?? (_controller.positions.isNotEmpty ? _controller.page : _controller.initialPage.toDouble());

    if (_lastValue != _value) {
      final isStopped = _value?.toInt() == _value;
      if (isStopped) {
        _goingReverse.value = null;
      } else {
        _goingReverse.value ??= (_value ?? 0.0) < _lastValue;
      }
      _lastValue = _value ?? 0.0;
      // markNeedsBuild();
    }

    // Report page change.
    final currentPage = _value?.round() ?? _controller.initialPage;
    if (currentPage != _lastReportedPage) {
      _lastReportedPage = currentPage;
      widget.onPageChanged?.call(currentPage);
    }
  }

  @override
  void initState() {
    _disposeController = widget.controller == null;
    _controller = widget.controller ?? PageController();
    _controller.addListener(_handleChange);
    _lastValue = _controller.initialPage.toDouble();
    _handleChange(value: _lastValue);
    super.initState();
  }

  @override
  void dispose() {
    if (_disposeController) {
      _controller.dispose();
    } else {
      _controller.removeListener(_handleChange);
    }

    super.dispose();
  }

  Widget _buildItem(BuildContext context, int i) => _MotionViewTransformedChildBuilder(
        index: i,
        controller: _controller,
        reverse: _goingReverse,
        axis: widget.swipeDirection,
        builder: widget.transitionBuilder,
        child: widget.itemBuilder(context, i),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PageView.custom(
      key: widget.pageViewKey,
      controller: _controller,
      scrollDirection: widget.swipeDirection,
      clipBehavior: widget.clipBehavior,
      physics: !widget.enableScroll ? const NeverScrollableScrollPhysics() : widget.physics,
      scrollBehavior: widget.scrollBehavior,
      allowImplicitScrolling: widget.allowImplicitScrolling,
      childrenDelegate: SliverChildBuilderDelegate(
        _buildItem,
        childCount: widget.itemCount,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: widget.addRepaintBoundaries,
      ),
    );
  }
}

/// Widget that builds the children for [MotionView].
///
/// It handles syncing of primary & secondary transition animations
/// to the [PageController] in the [MotionView].
class _MotionViewTransformedChildBuilder extends StatefulWidget {
  /// Creates [_MotionViewTransformedChildBuilder].
  const _MotionViewTransformedChildBuilder({
    super.key,
    required this.controller,
    required this.builder,
    required this.index,
    required this.child,
    required this.reverse,
    this.axis = Axis.horizontal,
    this.debug = false,
  });

  /// [PageController] that's gonna drive the primary and secondary animation
  /// of the children switcher animations.
  final PageController controller;

  /// Child widget that's wrapped in a transition.
  final Widget child;

  /// Index of this child, for syncing the animation value, relative to the page
  /// in the [PageController].
  final int index;

  /// Whether the [MotionView] is being reversed in reverse.
  final ValueNotifier<bool?> reverse;

  /// The scroll direction.
  final Axis axis;

  /// Builder of the transition.
  final PageTransitionSwitcherTransitionBuilder builder;

  /// Whether to overlay animation debug info over the children.
  final bool debug;

  @override
  _MotionViewTransformedChildBuilderState createState() => _MotionViewTransformedChildBuilderState();
}

class _MotionViewTransformedChildBuilderState extends State<_MotionViewTransformedChildBuilder>
    with TickerProviderStateMixin<_MotionViewTransformedChildBuilder> {
  late final AnimationController _primaryController;
  late final AnimationController _secondaryController;

  final _relativeValue = ValueNotifier(0.0);

  _Position get _position {
    if (widget.reverse.value == true) {
      return _Position.reverse;
    } else if (widget.reverse.value == false) {
      return _Position.forward;
    }

    if (_relativeValue.value < 0.0) {
      return _Position.reverse;
    } else if (_relativeValue.value > 0.0) {
      return _Position.forward;
    } else {
      return _Position.idle;
    }
  }

  _Direction get _direction {
    if (_relativeValue.value < 0.0) {
      return widget.reverse.value == true ? _Direction.outgoing : _Direction.incoming;
    } else {
      return widget.reverse.value != true ? _Direction.outgoing : _Direction.incoming;
    }
  }

  void _handleValueChange() {
    switch (_position) {
      case _Position.idle:
        _primaryController.value = 1.0;
        _secondaryController.value = 0.0;
        break;
      case _Position.forward:
        switch (_direction) {
          case _Direction.incoming:
            _primaryController.value = 1.0 - _relativeValue.value.abs();
            _secondaryController.value = 0.0;
            break;
          case _Direction.outgoing:
            _primaryController.value = 1.0;
            _secondaryController.value = _relativeValue.value.abs();
            break;
        }
        break;
      case _Position.reverse:
        switch (_direction) {
          case _Direction.incoming:
            _secondaryController.value = _relativeValue.value.abs();
            _primaryController.value = 1.0;
            break;
          case _Direction.outgoing:
            _primaryController.value = 1.0 - _relativeValue.value.abs();
            _secondaryController.value = 0.0;
            break;
        }
        break;
    }
  }

  void _handlePageController({double? value}) {
    final relativeValue = (value ??
                (widget.controller.positions.isNotEmpty
                    ? widget.controller.page ?? widget.controller.initialPage.toDouble()
                    : widget.controller.initialPage.toDouble()))
            .clamp(widget.index - 1, widget.index + 1)
            .toDouble() -
        widget.index;

    if (_relativeValue.value != relativeValue) {
      _relativeValue.value = relativeValue;
      _handleValueChange();
    }
  }

  @override
  void initState() {
    _primaryController = AnimationController(vsync: this);
    _secondaryController = AnimationController(vsync: this);
    widget.reverse.addListener(_handlePageController);
    widget.controller.addListener(_handlePageController);

    final page = _getPageSafe(widget.controller);
    _handlePageController(value: page);
    _handleValueChange();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _MotionViewTransformedChildBuilder oldWidget) {
    assert(oldWidget.controller == widget.controller);
    if (oldWidget.reverse != widget.reverse) _handlePageController();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.reverse.removeListener(_handlePageController);
    widget.controller.removeListener(_handlePageController);
    _primaryController.dispose();
    _secondaryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<double>(
        valueListenable: _relativeValue,
        child: widget.builder(widget.child, _primaryController, _secondaryController),
        builder: (_, relativeValue, child) {
          final offset = switch (widget.axis) {
            Axis.horizontal => Offset(relativeValue, 0),
            Axis.vertical => Offset(0, relativeValue),
          };

          return FractionalTranslation(translation: offset, child: child);
        },
      );
}

/// Try to get the page from the [controller], falling back to initialPage.
double _getPageSafe(PageController controller) {
  try {
    if (controller.page == null) throw Exception("PageController page is null.");
    return controller.page!;
  } catch (_) {
    return controller.initialPage.toDouble();
  }
}
