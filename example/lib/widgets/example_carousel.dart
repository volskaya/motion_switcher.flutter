import 'package:app/cubits/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:motion_switcher/motion_switcher.dart';

class ExampleCarousel extends HookWidget {
  const ExampleCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = context.watch<PageController>();
    final (
      products,
      expandedProduct,
    ) = context.read<HomePageCubit>().observe((s) => (
          s.products,
          s.expandedProduct,
        ));

    return RepaintBoundary(
      child: MotionView.horizontal(
        enableScroll: expandedProduct == null,
        wantKeepAlive: true,
        clipBehavior: Clip.none,
        controller: pageController,
        addRepaintBoundaries: false,
        itemCount: products.length,
        itemBuilder: (context, index) => MotionImage(
          imageProvider: AssetImage(products[index].imageAsset),
        ),
      ),
    );
  }
}
