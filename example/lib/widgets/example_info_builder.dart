import 'package:app/cubits/home_page_cubit.dart';
import 'package:app/models/product.dart';
import 'package:app/widgets/example_contents_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Calculates stagger offsets for the widgets in [ExampleInfoBlock].
class ExampleInfoBuilder extends HookWidget {
  const ExampleInfoBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    Product product,
    ExampleMotionViewStaggerProps stagger,
  ) builder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final pageController = context.watch<PageController>();
    final products = context.read<HomePageCubit>().observe((s) => s.products);

    return ExampleContentsBuilder(
      controller: pageController,
      alignment: Alignment.bottomCenter,
      itemCount: products.length,
      itemBuilder: (context, index, value) {
        final product = products[index];

        final badgeValue = ExampleContentsBuilder.curveBuilderValue(value, Curves.easeInOutCirc);
        final nameValue = ExampleContentsBuilder.curveBuilderValue(value, Curves.easeInOutQuart);
        final priceValue = ExampleContentsBuilder.curveBuilderValue(value, Curves.easeInOutCubic);

        final props = ExampleMotionViewStaggerProps(
          badgeOffset: Offset(size.width * badgeValue * -1.0, 0.0),
          nameOffset: Offset(size.width * nameValue * -1.0, 0.0),
          priceOffset: Offset(size.width * priceValue * -1.0, 0.0),
        );

        return builder(context, product, props);
      },
    );
  }
}

class ExampleMotionViewStaggerProps {
  ExampleMotionViewStaggerProps({
    required this.badgeOffset,
    required this.nameOffset,
    required this.priceOffset,
  });

  final Offset badgeOffset;
  final Offset nameOffset;
  final Offset priceOffset;
}
