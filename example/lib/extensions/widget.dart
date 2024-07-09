import 'package:flutter/widgets.dart';

extension WidgetListExt on List<Widget> {
  Iterable<Widget> spaceHorizontallyBy(double size) => expand((widget) sync* {
        yield SizedBox(width: size);
        yield widget;
      }).skip(1);

  Iterable<Widget> spaceVerticallyBy(double size) => expand((widget) sync* {
        yield SizedBox(height: size);
        yield widget;
      }).skip(1);

  Iterable<Widget> spaceWith(Widget widget) => expand((otherWidget) sync* {
        yield widget;
        yield otherWidget;
      }).skip(1);
}
