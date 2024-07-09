import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/design/motion.dart';
import 'package:app/design/typography.dart';
import 'package:app/widgets/buttons/our_button_builder.dart';
import 'package:app/widgets/our_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:motion_switcher/motion_switcher.dart';

class OurOutlinedButton extends StatelessWidget {
  const OurOutlinedButton({
    super.key,
    required this.child,
    required this.onTap,
    this.width = double.infinity,
    this.height = Dimensions.button,
    this.borderRadius = BorderRadii.button,
  });

  final Widget child;
  final VoidCallback onTap;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) => OurButtonBuilder(
        onTap: onTap,
        builder: (context, isPressed, isLoading, isDisabled) {
          final colors = OurColors.of(context);
          final typography = OurTypography.of(context);

          final contentColor = colors.onBackground;
          final overlayColor = contentColor.withOpacity(isPressed ? 0.2 : 0.0);
          final decoration = BoxDecoration(borderRadius: borderRadius, border: Borders.sm);

          return Container(
            width: width,
            height: height,
            clipBehavior: Clip.antiAlias,
            foregroundDecoration: decoration,
            decoration: decoration,
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
                    child: isLoading
                        ? const OurProgressIndicator()
                        : KeyedSubtree(
                            key: const ValueKey("child"),
                            child: child,
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
