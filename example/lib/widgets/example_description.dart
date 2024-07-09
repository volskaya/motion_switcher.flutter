import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/design/typography.dart';
import 'package:app/extensions/edge_insets.dart';
import 'package:app/models/product.dart';
import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';

class ExampleDescription extends StatelessWidget {
  const ExampleDescription({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final typography = OurTypography.of(context);
    final colors = OurColors.of(context);

    return Padding(
      padding: HomePage.contentPadding + padding.getSidesOnly(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Heights.md,
          Text(
            product.name,
            textAlign: TextAlign.center,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToLastDescent: false,
              applyHeightToFirstAscent: false,
              leadingDistribution: TextLeadingDistribution.proportional,
            ),
            style: typography.title3.copyWith(
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
              decorationStyle: TextDecorationStyle.solid,
              color: Colors.transparent,
              shadows: [
                // Using a shadow without blur and hiding real text,
                // to cheat the position a bit higher, above the underline.
                Shadow(color: colors.onBackground, offset: const Offset(0.0, -xxs)),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: !product.hasDiscount
                  ? [TextSpan(text: product.getPriceStr())]
                  : [
                      TextSpan(text: product.getDiscountStr()),
                      const TextSpan(text: " "),
                      TextSpan(
                        text: product.getPriceStr(),
                        style: typography.title.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2.0,
                          color: colors.hint,
                          decorationColor: colors.hint,
                        ),
                      ),
                    ],
            ),
            textAlign: TextAlign.center,
            style: typography.title,
          ),
          Heights.md,
          Text(
            "Overview",
            style: typography.footnote.copyWith(color: colors.accentPrimary),
          ),
          Heights.xs,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: typography.body,
          ),
          Heights.md,
          Heights.xxl,
          Heights.xxl,
          SizedBox(height: padding.bottom),
        ],
      ),
    );
  }
}
