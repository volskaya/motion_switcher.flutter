import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motion_switcher/src/motion_view_indicator_props.dart';

class MotionViewIndicator extends StatelessWidget {
  const MotionViewIndicator({
    super.key,
    required this.count,
    required this.animation,
    required this.props,
    this.axis = Axis.horizontal,
    this.size,
    this.spacing,
  });

  final ValueListenable<double> animation;
  final Axis axis;
  final int count;
  final MotionViewIndicatorProps props;
  final double? size;
  final double? spacing;

  int get _count => count < 1 ? 1 : count;

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 8.0;
    final spacing = this.spacing ?? 4.0;
    final mainAxisSize = switch (props) {
      MotionViewIndicatorPropsWide _ => double.infinity,
      _ => _count * size + (_count - 1) * spacing,
    };

    final painterSize = Size(
      axis == Axis.horizontal ? mainAxisSize : size,
      axis == Axis.vertical ? mainAxisSize : size,
    );

    final child = RepaintBoundary(
      child: CustomPaint(
        size: painterSize,
        painter: _BasePainter(
          animation: animation,
          props: props,
          axis: axis,
          count: _count,
          space: spacing,
          diameter: size,
        ),
      ),
    );

    return IgnorePointer(
      child: switch (props) {
        MotionViewIndicatorPropsWarm _ => child,
        MotionViewIndicatorPropsScale _ => ClipRect(child: child),
        MotionViewIndicatorPropsWide _ => child,
      },
    );
  }
}

class _BasePainter extends CustomPainter {
  _BasePainter({
    required this.animation,
    required this.props,
    required this.count,
    required this.axis,
    required this.diameter,
    required this.space,
  })  : _paint = Paint()..color = props.color,
        super(repaint: animation);

  final ValueListenable<double> animation;
  final Axis axis;
  final MotionViewIndicatorProps props;
  final double diameter;
  final double space;
  final int count;

  final Paint _paint;

  double get value => animation.value % count;
  int get index => value.toInt();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = diameter / 2.0;

    // Draws the inactive circles.
    switch (props) {
      case MotionViewIndicatorPropsScale props:
        for (int i = 0; i < count; i += 1) {
          if (index == count - 1 ? i == 0 || i == index : i == index || i == index + 1) continue;
          canvas.drawCircle(
            Offset(
              axis == Axis.horizontal ? i * (diameter + space) + radius : radius,
              axis == Axis.vertical ? i * (diameter + space) + radius : radius,
            ),
            radius * props.scale,
            _paint,
          );
        }
        break;
      case MotionViewIndicatorPropsWarm _:
        for (int i = 0; i < count; i += 1) {
          canvas.drawCircle(
            Offset(
              axis == Axis.horizontal ? i * (diameter + space) + radius : radius,
              axis == Axis.vertical ? i * (diameter + space) + radius : radius,
            ),
            radius,
            _paint,
          );
        }
        break;
      case MotionViewIndicatorPropsWide props:
        final space = this.space / 2;
        final spacingWidth = space / (count - 1);
        final rectWidth = size.width / count - space;

        for (int i = 0; i < count; i += 1) {
          final leftInset = (space + (i > 0 ? spacingWidth : 0.0)) * i;
          final left = (rectWidth * i) + leftInset;
          final rect = Offset(left, 0.0) & Size(rectWidth, diameter);

          if (props.borderRadius != null) {
            final rrect = RRect.fromRectAndCorners(
              rect,
              topLeft: props.borderRadius!.topLeft,
              topRight: props.borderRadius!.topRight,
              bottomLeft: props.borderRadius!.bottomLeft,
              bottomRight: props.borderRadius!.bottomRight,
            );
            canvas.drawRRect(rrect, _paint);
          } else {
            canvas.drawRect(rect, _paint);
          }
        }
        break;
    }

    // Draws the active circles.
    switch (props) {
      case MotionViewIndicatorPropsScale props:
        final secondOffset = index == count - 1 ? radius : radius + ((index + 1) * (diameter + space));
        final progress = value - index;
        final activePaint = Paint()..color = Color.lerp(props.color, props.activeColor, progress)!;

        // Last circle.
        canvas.drawCircle(
          Offset(
            axis == Axis.horizontal ? radius + (index * (diameter + space)) : radius,
            axis == Axis.vertical ? radius + (index * (diameter + space)) : radius,
          ),
          ui.lerpDouble(radius, radius * props.scale, progress)!,
          activePaint,
        );

        // First circle.
        canvas.drawCircle(
          Offset(
            axis == Axis.horizontal ? secondOffset : radius,
            axis == Axis.vertical ? secondOffset : radius,
          ),
          ui.lerpDouble(radius * props.scale, radius, progress)!,
          _paint,
        );
        break;
      case MotionViewIndicatorPropsWarm props:
        final progress = value - index;
        final distance = diameter + space;
        final start = index * (diameter + space);
        final activePaint = Paint()..color = props.activeColor;

        Rect rect;
        double right, left;

        if (progress > 0.5) {
          if (index != count - 1) {
            left = index * distance + distance * (progress - 0.5) * 2.0;
            right = start + diameter + distance;
          } else {
            // Wraps around from first to last circles.
            left = 0.0;
            right = ui.lerpDouble(start + diameter, diameter, progress * 2.0 - 1.0)!;
          }
        } else {
          if (index != count - 1) {
            left = start;
            right = start + diameter + distance * progress * 2.0;
          } else {
            // Wraps around from first to last circles.
            left = ui.lerpDouble(start, 0.0, progress * 2.0)!;
            right = start + diameter;
          }
        }

        switch (axis) {
          case Axis.horizontal:
            rect = Rect.fromLTRB(left, 0.0, right, diameter);
            break;
          case Axis.vertical:
            rect = Rect.fromLTRB(0, left, diameter, right);
            break;
        }

        canvas.drawPath(const StadiumBorder().getInnerPath(rect), activePaint);
        break;
      case MotionViewIndicatorPropsWide props:
        final activePaint = Paint()..color = props.activeColor;
        final space = this.space / 2;
        final spacingWidth = space / (count - 1);
        final rectWidth = size.width / count - space;

        final progress = value - index;
        final distance = rectWidth + spacingWidth + space;
        final offset = (space + (index > 0 ? spacingWidth : 0.0)) * index;
        final start = rectWidth * index + offset;

        Rect rect;
        double right, left;

        if (progress > 0.5) {
          if (index != count - 1) {
            left = distance * index + distance * (progress - 0.5) * 2.0;
            right = start + rectWidth + distance;
          } else {
            // Wraps around from first to last circles.
            left = 0.0;
            right = ui.lerpDouble(start + rectWidth, rectWidth, progress * 2.0 - 1.0)!;
          }
        } else {
          if (index != count - 1) {
            left = start;
            right = start + rectWidth + distance * progress * 2.0;
          } else {
            // Wraps around from first to last circles.
            left = ui.lerpDouble(start, 0.0, progress * 2.0)!;
            right = start + rectWidth;
          }
        }

        switch (axis) {
          case Axis.horizontal:
            rect = Rect.fromLTRB(left, 0.0, right, diameter);
            break;
          case Axis.vertical:
            rect = Rect.fromLTRB(0, left, diameter, right);
            break;
        }

        if (props.borderRadius != null) {
          final rrect = RRect.fromRectAndCorners(
            rect,
            topLeft: props.borderRadius!.topLeft,
            topRight: props.borderRadius!.topRight,
            bottomLeft: props.borderRadius!.bottomLeft,
            bottomRight: props.borderRadius!.bottomRight,
          );
          canvas.drawRRect(rrect, activePaint);
        } else {
          canvas.drawRect(rect, activePaint);
        }
        break;
    }
  }

  @override
  bool shouldRepaint(_BasePainter oldDelegate) =>
      oldDelegate.props != props ||
      oldDelegate.count != count ||
      oldDelegate.axis != axis ||
      oldDelegate.diameter != diameter ||
      oldDelegate.space != space ||
      oldDelegate.count != count;
}
