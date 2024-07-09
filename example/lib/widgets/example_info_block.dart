import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/design/typography.dart';
import 'package:app/models/product.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/widgets/example_info_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Expected to be built in [ExampleInfoBuilder].
class ExampleInfoBlock extends StatelessWidget {
  const ExampleInfoBlock({
    super.key,
    required this.product,
    required this.stagger,
  });

  final Product product;
  final ExampleMotionViewStaggerProps stagger;

  @override
  Widget build(BuildContext context) {
    final typography = OurTypography.of(context);
    final colors = OurColors.of(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.badge != null)
            // Badges above text.
            Transform.translate(
              offset: stagger.badgeOffset,
              child: Container(
                color: colors.background,
                margin: HomePage.contentPadding,
                padding: Paddings.xxs,
                child: Text(
                  product.badge!,
                  style: typography.footnote,
                ),
              ),
            ),

          Heights.xs,

          // Name.
          Transform.translate(
            offset: stagger.nameOffset,
            child: Padding(
              padding: HomePage.contentPadding,
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: typography.title3,
              ),
            ),
          ),

          // Price.
          Transform.translate(
            offset: stagger.priceOffset,
            child: Padding(
              padding: HomePage.contentPadding,
              child: Text.rich(
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
                              color: colors.accentPrimary,
                              decorationColor: colors.accentPrimary,
                            ),
                          ),
                        ],
                ),
                style: typography.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
