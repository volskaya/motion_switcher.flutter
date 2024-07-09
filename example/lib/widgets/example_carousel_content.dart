import 'package:app/cubits/home_page_cubit.dart';
import 'package:app/design/colors.dart';
import 'package:app/design/motion.dart';
import 'package:app/design/tokens.dart';
import 'package:app/design/typography.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/services/alert_service_state.dart';
import 'package:app/widgets/example_info_block.dart';
import 'package:app/widgets/example_info_builder.dart';
import 'package:app/widgets/example_page_indicator.dart';
import 'package:app/widgets/our_app_bar.dart';
import 'package:app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:motion_switcher/motion_switcher.dart';

class ExampleCarouselContent extends HookWidget {
  const ExampleCarouselContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    final (expandedProduct, products) = cubit.observe((s) => (s.expandedProduct, s.products));

    final padding = MediaQuery.paddingOf(context);
    final orientation = MediaQuery.orientationOf(context);
    final typography = OurTypography.of(context);
    final colors = OurColors.of(context);
    final pageController = context.watch<PageController>();

    return MotionSwitcher(
      duration: Motion.durations.medium,
      alignment: Alignment.bottomCenter,
      child: expandedProduct != null
          ? null
          : Padding(
              padding: padding + const EdgeInsets.only(top: OurAppBar.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (orientation == Orientation.landscape)
                    const Spacer()
                  else
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Padding(
                          padding: Horizontals.xxs,
                          child: IgnorePointer(
                            child: Text(
                              "Get from pub.dev or source @ github.com",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: typography.largeTitle,
                            ),
                          ),
                        ),
                      ),
                    ),

                  IgnorePointer(
                    child: AnimatedLayout(
                      duration: Motion.durations.medium,
                      curve: Motion.curves.emphasized,
                      alignment: Alignment.bottomCenter,
                      child: ExampleInfoBuilder(
                        builder: (context, product, stagger) => ExampleInfoBlock(
                          product: product,
                          stagger: stagger,
                        ),
                      ),
                    ),
                  ),

                  Heights.sm,

                  // Buttons below text.
                  Padding(
                    padding: HomePage.contentPadding,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: xxl,
                          height: xxl,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: colors.accentPrimary),
                          child: OurButton.circle(
                            onTap: const Alert.unimplementedTemplate().notify,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: colors.onAccentPrimary,
                            ),
                          ),
                        ),
                        Widths.xs,
                        Container(
                          width: xxl,
                          height: xxl,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: colors.background),
                          child: OurButton.circle(
                            onTap: () {
                              final page = (pageController.page ?? 0.0).round();
                              final selectedProduct = products[page];

                              cubit.expandProduct(selectedProduct);
                            },
                            child: Icon(
                              Icons.arrow_downward_rounded,
                              color: colors.onBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Heights.md,

                  // Carousel progress indicators under the rest of the content.
                  const IgnorePointer(
                    child: ExamplePageIndicator(),
                  ),
                ],
              ),
            ),
    );
  }
}
