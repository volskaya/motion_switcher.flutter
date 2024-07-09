import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/design/motion.dart';
import 'package:app/design/typography.dart';
import 'package:app/widgets/buttons/our_button_builder.dart';
import 'package:app/widgets/our_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:motion_switcher/motion_switcher.dart';

class OurColoredButton extends StatelessWidget {
  const OurColoredButton({
    super.key,
    required this.child,
    required this.onTap,
    this.width = double.infinity,
    this.height = Dimensions.button,
    this.shape = const StadiumBorder(),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) => OurButtonBuilder(
        onTap: onTap,
        builder: (context, isPressed, isLoading, isDisabled) {
          final colors = OurColors.of(context);
          final typography = OurTypography.of(context);

          final containerColor = colors.onBackground.withOpacity(isDisabled || isLoading ? 0.5 : 1.0);
          final contentColor = colors.background;
          final overlayColor = contentColor.withOpacity(isPressed ? 0.2 : 0.0);

          return AnimatedContainer(
            duration: Motion.durations.fast,
            curve: Motion.curves.emphasized,
            width: width,
            height: height,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(shape: shape, color: containerColor),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                // This is a slight fade when the button is pressed.
                Positioned.fill(
                  child: TweenAnimationBuilder(
                    tween: ColorTween(end: overlayColor),
                    duration: Motion.durations.fast,
                    curve: Motion.curves.emphasized,
                    builder: (context, color, ___) => ColoredBox(color: color!),
                  ),
                ),

                DefaultTextStyle(
                  style: typography.body.copyWith(color: contentColor),
                  textAlign: TextAlign.center,
                  child: MotionSwitcher(
                    duration: Motion.durations.medium,
                    alignment: Alignment.center,
                    reverse: false,
                    child: isLoading ? OurProgressIndicator(color: contentColor) : child,
                  ),
                ),
              ],
            ),
          );
        },
      );
}
