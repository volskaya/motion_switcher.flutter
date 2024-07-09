import 'package:app/cubits/home_page_cubit.dart';
import 'package:app/design/colors.dart';
import 'package:app/design/motion.dart';
import 'package:app/design/tokens.dart';
import 'package:app/services/alert_service_state.dart';
import 'package:app/utils/our_page_widget.dart';
import 'package:app/widgets/example_carousel.dart';
import 'package:app/widgets/example_carousel_content.dart';
import 'package:app/widgets/example_description.dart';
import 'package:app/widgets/example_motion_switcher.dart';
import 'package:app/widgets/our_app_bar.dart';
import 'package:app/widgets/our_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:motion_switcher/motion_switcher.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends OurPageWidget<HomePageCubit> {
  const HomePage({super.key});

  static const contentPadding = Horizontals.sm;

  @override
  HomePageCubit buildCubit(BuildContext context) => HomePageCubit();

  @override
  Widget buildWidget(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context);
    final size = MediaQuery.sizeOf(context);
    final colors = OurColors.of(context);

    final scrollController = useScrollController();
    final pageController = usePageController();

    final cubit = context.read<HomePageCubit>();
    final expandedProduct = cubit.observe((s) => s.expandedProduct);

    return Provider<PageController>.value(
      value: pageController,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            ListView(
              controller: scrollController,
              physics: expandedProduct == null ? const NeverScrollableScrollPhysics() : null,
              padding: EdgeInsets.zero,
              children: [
                // The carousel shrinks when a product is expanded.
                AnimatedContainer(
                  duration: Motion.durations.slow,
                  curve: Motion.curves.emphasized,
                  width: double.infinity,
                  height: expandedProduct != null ? size.height * 0.5 : size.height,
                  child: const Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      ExampleCarousel(),
                      ExampleCarouselContent(),
                    ],
                  ),
                ),

                // Description / info scrollable content, that animate in when expanding a product.
                //
                // Notice the [Intervals] curve the animation to instantly fade in and delay fade out
                // to the last milliseconds, so it looks like the description is still there, as the carousel
                // is animated back to its full size.
                AnimatedLayout(
                  duration: Motion.durations.slow,
                  curve: Motion.curves.emphasized,
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  child: AnimatedSwitcher(
                    duration: Motion.durations.slow,
                    transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                    switchInCurve: Interval(0.0, 0.0, curve: Motion.curves.emphasized),
                    switchOutCurve: Interval(0.0, 0.2, curve: Motion.curves.emphasizedDecelerate),
                    child: expandedProduct == null
                        ? const SizedBox(width: double.infinity)
                        : ExampleDescription(product: expandedProduct),
                  ),
                ),
              ],
            ),

            // A dark gradient at the bottom of the screen that only animates in
            // when a product is expanded.
            Align(
              alignment: Alignment.bottomCenter,
              child: RepaintBoundary(
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: Motion.durations.slow,
                    curve: Motion.curves.emphasized,
                    width: double.infinity,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      gradient: expandedProduct == null
                          ? null
                          : LinearGradient(
                              colors: [
                                colors.background,
                                colors.background.withOpacity(0.98),
                                colors.background.withOpacity(0.0),
                              ],
                              stops: const [0.0, 0.2, 1.0],
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                            ),
                    ),
                  ),
                ),
              ),
            ),

            // The app bar above the scrollable.
            OurAppBar(
              // Only animate the button in when there's an expanded product.
              backButton: expandedProduct != null
                  ? Container(
                      width: orientation == Orientation.landscape ? lg : xxl,
                      height: orientation == Orientation.landscape ? lg : xxl,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.accentPrimary,
                      ),
                      child: OurButton.circle(
                        onTap: () {
                          cubit.collapseProduct();
                          scrollController.animateTo(
                            0.0,
                            duration: Motion.durations.slow,
                            curve: Motion.curves.emphasized,
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: colors.background,
                        ),
                      ),
                    )
                  : null,
              buttons: [
                OurButton.circle(
                  onTap: const Alert.unimplementedTemplate().notify,
                  child: const Icon(Icons.search_outlined),
                ),
                OurButton.circle(
                  onTap: const Alert.unimplementedTemplate().notify,
                  child: const Icon(Icons.person_outline),
                )
              ],
            ),

            // Action button that only animates in when a product is expanded.
            const Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                child: Padding(
                  padding: Paddings.sm,
                  child: ExampleMotionSwitcher(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
