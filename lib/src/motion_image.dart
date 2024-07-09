import 'package:flutter/widgets.dart' hide Image;
import 'package:motion_switcher/src/builders/motion_image_opacity_builder.dart';
import 'package:motion_switcher/src/motion_switcher.dart';
import 'package:motion_switcher/src/transparent_image.dart';
import 'package:motion_switcher/src/widgets/image.dart';
import 'package:other_animations/other_animations.dart';

/// Transition types of the internal animated switcher of [MotionImage].
enum MotionImageType {
  fade,
  scale,
  axisHorizontal,
  axisVertical,
  instant,
}

/// Gapless, animated image widget.
///
/// Used as you would use the default Flutter's image widget.
class MotionImage extends StatelessWidget {
  /// Creates [MotionImage].
  const MotionImage({
    super.key,
    required this.imageProvider,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.borderRadius,
    this.shape,
    this.duration,
    this.curve,
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.type,
    this.opacity,
    this.alignment = Alignment.center,
    this.addRepaintBoundary = false,
    this.resize = false,
    this.expandBox = false,
    this.optimizeFade,
  })  : colorBlendMode = null,
        color = null,
        filter = false;

  /// Creates a fading [MotionImage] with a filter.
  /// The filter is only applied to the [RawImage]s.
  const MotionImage.filter({
    super.key,
    required this.imageProvider,
    required this.color,
    this.colorBlendMode = BlendMode.saturation,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.borderRadius,
    this.shape,
    this.duration,
    this.curve,
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.opacity,
    this.alignment = Alignment.center,
    this.addRepaintBoundary = false,
    this.resize = false,
    this.expandBox = false,
    this.optimizeFade,
  })  : type = MotionImageType.fade,
        filter = true;

  /// The default duration of transitions. Feel free to reassign this.
  static Duration transitionDuration = const Duration(milliseconds: 300);

  /// The default curve of transitions. Feel free to reassign this.
  /// This only works for [MotionImageType.fade] as the other types use transitions from the animations package.
  static Curve transitionCurve = Motion.easing.emphasizedDecelerate;

  /// The default type of [MotionImage]s.
  static MotionImageType transitionType = MotionImageType.fade;

  /// When this is set to `true`, the image switching animation will animate
  /// the alpha color of the image, if the animating child is [RawImage].
  static bool enableRawImageOptimization = true;

  /// Transparent image used as an identifier for when there's no actual image loaded.
  static final transparentImage = MemoryImage(kTransparentImage, scale: 1);

  /// [ImageProvider] to switch to.
  final ImageProvider? imageProvider;

  /// While [MotionImage.imageProvider] is not loaded an optional
  /// [idleChild] will be built instead.
  final Widget? idleChild;

  /// Child [Widget]s in the switcher's layout builder.
  final Iterable<Widget> layoutChildren;

  /// Clip rect shape of the animated switcher box.
  final BorderRadius? borderRadius;

  /// Clip shape of the animated switcher box.
  final ShapeBorder? shape;

  /// Duration of the switch transition.
  final Duration? duration;

  /// Curve of the switch transition.
  final Curve? curve;

  /// Filter quality of the image.
  final FilterQuality filterQuality;

  /// Box fit of the image.
  final BoxFit fit;

  /// Transition type used by the animated switcher within [MotionImage].
  final MotionImageType? type;

  /// Opacity override when you wish to animate the image without having to overlap
  /// multiple opacity shaders.
  final Animation<double>? opacity;

  /// Alignment of the children in the switchers.
  final AlignmentGeometry alignment;

  /// Blend mode of the internal [ColorFiltered] filter.
  final BlendMode? colorBlendMode;

  /// Color of the internal [ColorFiltered] filter.
  final Color? color;

  /// Whether to wrap images in a [ColorFiltered] widget.
  final bool filter;

  /// Whether to wrap images in a [RepaintBoundary] widget.
  final bool addRepaintBoundary;

  /// Whether to use [ResizeImage] & [LayoutBuilder] on the image provider.
  final bool resize;

  /// Whether to wrap the widget in [SizedBox.expand].
  final bool expandBox;

  /// Override for [MotionImage.enableRawImageOptimization].
  final bool? optimizeFade;

  /// Default fade transition of [MotionImage].
  static Widget fadeTransition(
    MotionImageType type,
    Widget widget,
    Animation<double> animation, {
    Animation<double>? opacity,
    Widget Function(Widget child)? wrap,
    BlendMode? colorBlendMode,
    Color? color,
    bool filter = false,
    bool optimizeFade = false,
  }) {
    // No shader opacity optimization by setting the color opacity on the image.
    if (optimizeFade && widget is RawImage) {
      final image = MotionImageOpacityBuilder(
        transition: animation,
        opacityOverride: opacity,
        builder: (_, opacity) => RawImage(
          key: widget.key,
          height: widget.height,
          width: widget.width,
          alignment: widget.alignment,
          fit: widget.fit,
          scale: widget.scale,
          repeat: widget.repeat,
          centerSlice: widget.centerSlice,
          isAntiAlias: widget.isAntiAlias,
          invertColors: widget.invertColors,
          filterQuality: widget.filterQuality,
          debugImageLabel: widget.debugImageLabel,
          matchTextDirection: widget.matchTextDirection,
          image: widget.image,
          opacity: opacity,
        ),
      );

      return wrap?.call(image) ?? image;
    } else {
      final child = wrap?.call(widget) ?? widget;
      return Animations.fade(
        opacity: animation,
        child: child,
      );
    }
  }

  /// Default layout builder of [MotionImage].
  static Widget layoutBuilder(
    Widget? currentChild,
    Iterable<Widget> previousChildren, [
    AlignmentGeometry alignment = Alignment.center,
    Iterable<Widget> layoutChildren = const <Widget>[],
  ]) {
    assert((() {
      for (final child in layoutChildren) if (child.key == null) return false;
      return true;
    })(), 'Missing key on a layout child for a switching image.');

    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      alignment: alignment,
      children: <Widget>[
        ...previousChildren,
        if (currentChild != null) currentChild,
        ...layoutChildren,
      ],
    );
  }

  /// If [MotionImage.borderRadius] is not null, wrap the image in [ClipPath].
  Widget _withWrap(Widget childImage, {bool useFilter = false}) {
    final shouldFilter = useFilter && filter && childImage is RawImage;
    final shouldShape = shape != null || borderRadius != null;

    Widget child = childImage;

    // Both `colorBlendMode` and `color` will be passed, if [MotionImage]
    // is supposed to use the filter.
    if (shouldFilter && color != null && colorBlendMode != null) {
      child = ColorFiltered(
        colorFilter: ColorFilter.mode(color!, colorBlendMode!),
        child: RepaintBoundary(child: child), // Boundary necessary to mark the tree stable.
      );
    }

    if (shouldShape) {
      child = shape != null
          ? ClipPath(clipper: ShapeBorderClipper(shape: shape!), child: child)
          : ClipRRect(borderRadius: borderRadius ?? BorderRadius.zero, child: child);
    }

    return KeyedSubtree(key: childImage.key, child: child);
    // return RepaintBoundary(key: childImage.key, child: child);
  }

  Widget _frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    final type = this.type ?? transitionType;
    final rawImage = child as RawImage?;
    final hasFrames = frame != null || wasSynchronouslyLoaded;
    final hasGaplessImage = rawImage?.image != null;
    final isNotTransparent = rawImage?.image?.width != 1.0 && rawImage?.image?.height != 1.0;
    final switcherChild = isNotTransparent && (hasFrames || hasGaplessImage) ? rawImage : _idleChild;

    switch (type) {
      case MotionImageType.scale:
      case MotionImageType.axisHorizontal:
      case MotionImageType.axisVertical:
        Widget? child;

        if (switcherChild != null) {
          if (switcherChild is RawImage) {
            child = _withWrap(
              MotionImageOpacityBuilder(
                key: switcherChild.key,
                opacityOverride: opacity,
                builder: (_, opacity) => RawImage(
                  key: switcherChild.key,
                  height: switcherChild.height,
                  width: switcherChild.width,
                  alignment: switcherChild.alignment,
                  fit: switcherChild.fit,
                  scale: switcherChild.scale,
                  repeat: switcherChild.repeat,
                  centerSlice: switcherChild.centerSlice,
                  isAntiAlias: switcherChild.isAntiAlias,
                  invertColors: switcherChild.invertColors,
                  filterQuality: switcherChild.filterQuality,
                  debugImageLabel: switcherChild.debugImageLabel,
                  matchTextDirection: switcherChild.matchTextDirection,
                  image: switcherChild.image,
                  opacity: opacity,
                ),
              ),
              useFilter: true,
            );
          } else {
            child = _withWrap(switcherChild, useFilter: true);
          }
        }

        switch (type) {
          case MotionImageType.scale:
            return MotionSwitcher(
              duration: duration ?? MotionImage.transitionDuration,
              alignment: alignment,
              addRepaintBoundary: false,
              wrapChildrenInRepaintBoundary: false, // Handled by the wrap.
              child: child,
            );
          case MotionImageType.axisHorizontal:
            return MotionSwitcher.horizontal(
              duration: duration ?? MotionImage.transitionDuration,
              alignment: alignment,
              addRepaintBoundary: false,
              wrapChildrenInRepaintBoundary: false, // Handled by the wrap.
              child: child,
            );
          case MotionImageType.axisVertical:
            return MotionSwitcher.vertical(
              duration: duration ?? MotionImage.transitionDuration,
              alignment: alignment,
              addRepaintBoundary: false,
              wrapChildrenInRepaintBoundary: false, // Handled by the wrap.
              child: child,
            );
          default:
            throw 'Unreachable code';
        }
      case MotionImageType.fade:
        return AnimatedSwitcher(
          duration: duration ?? MotionImage.transitionDuration,
          switchInCurve: curve ?? MotionImage.transitionCurve,
          switchOutCurve: const Threshold(0),
          child: switcherChild,
          layoutBuilder: (child, children) => MotionImage.layoutBuilder(child, children, alignment, layoutChildren),
          transitionBuilder: (context, animation) => MotionImage.fadeTransition(
            type,
            context,
            animation,
            opacity: opacity,
            wrap: _withWrap,
            colorBlendMode: colorBlendMode,
            color: color,
            filter: filter,
            optimizeFade: optimizeFade ?? MotionImage.enableRawImageOptimization,
          ),
        );
      case MotionImageType.instant:
        return switcherChild != null ? _withWrap(switcherChild, useFilter: true) : _idleChild;
    }
  }

  Widget get _idleChild => SizedBox.expand(child: idleChild);

  Widget _buildImage(
    BuildContext context, [
    BoxConstraints? constraints,
  ]) {
    var pixelRatio = 1.0;

    // Only for the [ResizeImage] below.
    if (constraints != null) {
      pixelRatio = MediaQuery.devicePixelRatioOf(context);
    }

    return Image(
      fit: fit,
      width: expandBox ? double.infinity : null,
      height: expandBox ? double.infinity : null,
      filterQuality: filterQuality,
      gaplessPlayback: true,
      excludeFromSemantics: true,
      frameBuilder: _frameBuilder,
      image: imageProvider != null
          ? constraints != null
              ? ResizeImage(
                  imageProvider!,
                  width: (constraints.biggest.width * pixelRatio).round(),
                  height: (constraints.biggest.height * pixelRatio).round(),
                )
              : imageProvider!
          : MotionImage.transparentImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget image = resize ? LayoutBuilder(builder: _buildImage) : _buildImage(context);

    if (addRepaintBoundary) image = RepaintBoundary(child: image);
    if (expandBox) image = SizedBox.expand(child: image);

    return image;
  }
}
