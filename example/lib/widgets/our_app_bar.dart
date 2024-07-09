import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/design/motion.dart';
import 'package:app/design/typography.dart';
import 'package:app/services/alert_service_state.dart';
import 'package:app/widgets/our_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:motion_switcher/motion_switcher.dart';

class OurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OurAppBar({
    super.key,
    this.allowPopRoute = true,
    this.backButton,
    this.buttons = const [],
  });

  final bool allowPopRoute;
  final Widget? backButton;
  final List<Widget> buttons;

  static const height = Dimensions.xl;
  static const size = Size.fromHeight(height);

  @override
  Size get preferredSize => size;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final router = AutoRouter.of(context);
    final colors = OurColors.of(context);
    final typography = OurTypography.of(context);

    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        height: Dimensions.xl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Widths.xs,

            Expanded(
              child: AnimatedLayout(
                clipBehavior: Clip.none,
                duration: Motion.durations.medium,
                curve: Motion.curves.emphasized,
                alignment: Alignment.centerLeft,
                child: MotionSwitcher(
                  alignment: Alignment.centerLeft,
                  duration: Motion.durations.medium,
                  child: backButton != null
                      ? backButton!
                      : router.canPop() && allowPopRoute
                          ? OurButton(
                              width: Dimensions.button,
                              height: Dimensions.button,
                              onTap: router.maybePop,
                              child: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(
                                  Icons.trending_flat,
                                  size: Dimensions.lg,
                                ),
                              ),
                            )
                          : Text(
                              "MTNSWCH®",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: typography.title2,
                            ),
                ),
              ),
            ),

            // const Spacer(),
            ...buttons.expand((button) sync* {
              yield Widths.xxs;
              yield button;
            }).skip(1),

            Widths.xs,

            // There's always a menu button at the end.
            ColoredBox(
              color: colors.background,
              child: OurButton(
                width: xl,
                height: xl,
                shape: null,
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  const Alert.unimplementedTemplate().notify();
                },
                child: Icon(
                  Icons.menu_sharp,
                  color: colors.accentPrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
