import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This theming is inspired by iOS.
///
/// We're not using Material3 or any older versions of that here,
/// that Flutter uses by default because I just don't like them.
class OurColors {
  const OurColors({
    required this.brightness,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.accentPrimary,
    required this.onAccentPrimary,
    required this.accentSecondary,
    required this.onAccentSecondary,
    required this.accentTertiary,
    required this.onAccentTertiary,
    required this.error,
    required this.onError,
    required this.hint,
  });

  final Brightness brightness;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color accentPrimary;
  final Color onAccentPrimary;
  final Color accentSecondary;
  final Color onAccentSecondary;
  final Color accentTertiary;
  final Color onAccentTertiary;
  final Color error;
  final Color onError;
  final Color hint;

  // The design for the app we're building in this lesson only has a dark theme.
  static const dark = OurColors(
    brightness: Brightness.dark,
    background: Color(0xFF111111),
    // background: Color(0xFF000000),
    onBackground: Color(0xFFFFFFFF),
    surface: Color(0xFF212121),
    onSurface: Color(0xFFFFFFFF),
    // accentPrimary: Color(0xffC7B9A9),
    accentPrimary: Color(0xff00FF98),
    onAccentPrimary: Color(0xFF000000),
    accentSecondary: Color(0xFFC7A57B),
    onAccentSecondary: Color(0xFFFFFFFF),
    accentTertiary: Color(0xFFA9B4C7),
    onAccentTertiary: Color(0xFF000000),
    error: Color(0xFFFF1652),
    onError: Color(0xFFFFFFFF),
    hint: Color(0xFF747474),
  );

  static OurColors of(BuildContext context, {bool listen = true}) => Provider.of<OurColors>(context, listen: listen);
}

extension OurColorsExt on OurColors {
  /// [OurColors] aren't meant for Material3 and this [ColorScheme]
  /// just serves as a temporary placeholder for defaults widgets.
  ColorScheme getSimilarFlutterColorScheme() => ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: accentPrimary,
        surface: surface,
        onSurface: onSurface,
      ).copyWith(
        surface: surface,
        onSurface: onSurface,
        primary: accentPrimary,
        onPrimary: onAccentPrimary,
        secondary: accentSecondary,
        onSecondary: onAccentSecondary,
        tertiary: accentTertiary,
        onTertiary: onAccentTertiary,
        error: error,
        onError: onError,
      );

  ThemeData getSimilarFlutterTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: getSimilarFlutterColorScheme(),
      );
}
