# 🎬 Motion Switcher

This package includes multiple, very easy to use widgets to wrap your own widgets in animations.

The animations are implicit and don't require you to create your own states or choreography.

<image width="230" src="https://github.com/volskaya/motion_switcher.flutter/assets/38878482/b54c2c3d-7c7a-4607-9fb2-3c172f3ec88e"/>

# ✨ Widgets

- **MotionSwitcher** - animates the switch between its child widgets, similar to `AnimatedSwitcher`.
- **MotionImage** - loads and animates images, based on their provider changes.
- **MotionView** - animates carousel scrolling, similar to `PageView`.
- **MotionViewIndicator** - widget to quickly implement page indicators for `MotionView`.

# 🎁 Examples

For detailed examples and an app you can interact with, check the `lib/widgets/example_` widgets in [examples](https://github.com/volskaya/motion_switcher.flutter/tree/main/example/lib/widgets).

###### MotionSwitcher animating a list, as it loads in.

```dart
final list = switch (listStatus) {
  ListStatus.loading => CircularProgressIndicator();
  ListStatus.empty => Text("Nothing here");
  ListStatus.paginated => ListView(...);
}

// The child widget will be animated, since it's different in type.
//
// Animating widgets of the same type can be done by differentiating
// them with a unique key or using [MotionSwitcherTag].
return MotionSwitcher.vertical(child: list);
```

###### MotionImage loading & animating in a network image.

```dart
return MotionImage(
  imageProvider: NetworkImage(...),
  idleChild: CircularProgressIndicator(),
);
```

###### MotionView animating a carousel of text widgets.

```dart
return MotionView.horizontal(
  controller: pageController,
  clipBehavior: Clip.none,
  itemCount: 4,
  itemBuilder: (context, index) => Text("Showing item $index"),
)
```

## Detailed examples.

- **MotionSwitcher** - [examples/lib/widgets/example_motion_switcher.dart](https://github.com/volskaya/motion_switcher.flutter/blob/main/example/lib/widgets/example_motion_switcher.dart)
- **MotionImage** - [examples/lib/widgets/example_carousel.dart](https://github.com/volskaya/motion_switcher.flutter/blob/main/example/lib/widgets/example_carousel.dart)
- **MotionView** - [examples/lib/widgets/example_carousel.dart](https://github.com/volskaya/motion_switcher.flutter/blob/main/example/lib/widgets/example_carousel.dart)
- **MotionViewIndicator** - [examples/lib/widgets/example_page_indicator.dart](https://github.com/volskaya/motion_switcher.flutter/blob/main/example/lib/widgets/example_page_indicator.dart)
