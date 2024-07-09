import 'package:app/cubits/home_page_cubit.dart';
import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/services/alert_service_state.dart';
import 'package:app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:motion_switcher/motion_switcher.dart';

class ExampleMotionSwitcher extends HookWidget {
  const ExampleMotionSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = OurColors.of(context);
    final expandedProduct = context.watch<HomePageCubit>().observe((s) => s.expandedProduct);

    // Wrapped in a [MotionSwitcher] to animate the button in / out, depending
    // on whether there's an expanded product.
    return MotionSwitcher(
      alignment: Alignment.bottomRight,
      child: expandedProduct == null
          ? null
          : Container(
              width: xxl,
              height: xxl,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.accentPrimary,
              ),
              child: OurButton.circle(
                onTap: const Alert.unimplementedTemplate().notify,
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: colors.background,
                ),
              ),
            ),
    );
  }
}
