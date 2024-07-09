import 'package:app/cubits/home_page_cubit.dart';
import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:motion_switcher/motion_switcher.dart';
import 'package:page_controller_listenable/page_controller_listenable.dart';

class ExamplePageIndicator extends HookWidget {
  const ExamplePageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.read<HomePageCubit>().observe((s) => s.products);

    final pageController = context.watch<PageController>();
    final pageControllerListenable = usePageControllerListenable(pageController);

    final colors = OurColors.of(context);

    return Padding(
      padding: HomePage.contentPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Page indicator here animating based on [pageControllerListenable].
          MotionViewIndicator(
            count: products.length,
            animation: pageControllerListenable,
            axis: Axis.horizontal,
            size: xxs,
            spacing: xxs,
            props: MotionViewIndicatorPropsWarm(
              color: colors.background,
              activeColor: colors.onBackground,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_left, color: colors.background),
          Icon(Icons.chevron_right, color: colors.background),
        ],
      ),
    );
  }
}
