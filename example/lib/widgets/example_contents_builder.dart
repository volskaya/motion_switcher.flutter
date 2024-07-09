import 'package:flutter/material.dart';

/// This widget listens to [controller] and only builds the
/// widgets for pages, that would be visible, depending on
/// the animation value.
class ExampleContentsBuilder extends StatefulWidget {
  const ExampleContentsBuilder({
    super.key,
    required this.controller,
    this.clipBehavior = Clip.none,
    this.alignment = Alignment.center,
    required this.itemCount,
    required this.itemBuilder,
  });

  final PageController controller;
  final Clip clipBehavior;
  final Alignment alignment;
  final int itemCount;
  final Function(
    BuildContext context,
    int page,
    double value,
  ) itemBuilder;

  @override
  State<ExampleContentsBuilder> createState() => _ExampleContentsBuilderState();

  /// This curve function normalizes the [ExampleContentsBuilder] -1.0 .. 1.0 value
  /// to 0.0 .. 1.0 and transforms it with [curve], then normalizes it back.
  static double curveBuilderValue(double value, Curve curve) =>
      value >= 0.0 ? curve.transform(value) : -1.0 + curve.transform(value + 1.0);
}

class _ExampleContentsBuilderState extends State<ExampleContentsBuilder> {
  double get _page => widget.controller.page ?? 0.0;

  void _handlePageChange() {
    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(_handlePageChange);
    super.initState();
  }

  @override
  void didUpdateWidget(ExampleContentsBuilder oldWidget) {
    if (oldWidget.controller != widget.controller) widget.controller.addListener(_handlePageChange);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handlePageChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // There are only ever 2 pages built.
    final a = _page;
    final b = a != a.floor() && (a + 1.0 < widget.itemCount.toDouble()) ? a + 1.0 : null;
    final values = [a, if (b != null) b];

    return Stack(
      clipBehavior: widget.clipBehavior,
      alignment: widget.alignment,
      children: values.map((value) {
        final page = value.floor();
        final key = ValueKey(page);

        // Needs to go from -1.0 to 1.0, since the page "slides" in and out.
        final effectiveValue = _page - page;

        return Builder(
          key: key,
          builder: (context) => widget.itemBuilder(context, page, effectiveValue),
        );
      }).toList(growable: false),
    );
  }
}
