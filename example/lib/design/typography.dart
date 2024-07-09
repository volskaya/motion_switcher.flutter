import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurTypography {
  const OurTypography._({
    required this.largeTitle,
    required this.title3,
    required this.title2,
    required this.title,
    required this.headline,
    required this.subheadline,
    required this.body,
    required this.callout,
    required this.footnote,
    required this.caption,
    required this.caption2,
  });

  final TextStyle largeTitle;
  final TextStyle title3;
  final TextStyle title2;
  final TextStyle title;
  final TextStyle headline;
  final TextStyle subheadline;
  final TextStyle body;
  final TextStyle callout;
  final TextStyle footnote;
  final TextStyle caption;
  final TextStyle caption2;

  static OurTypography of(BuildContext context, {bool listen = true}) =>
      Provider.of<OurTypography>(context, listen: listen);

  static TextStyle getOurTextStyle(
    double size,
    double leading, {
    FontWeight weight = FontWeight.normal,
    double? spacing,
  }) =>
      TextStyle(
        fontFamily: "Kanit",
        fontWeight: weight,
        fontSize: size * 1.2, // NOTE: Hard scaled all our styles.
        letterSpacing: spacing,
        height: 1.0 * (1 + (leading / 100)),
        fontFeatures: const [],
      );

  static final large = OurTypography._(
    largeTitle: getOurTextStyle(58, 10, weight: FontWeight.bold),
    title3: getOurTextStyle(48, 34, weight: FontWeight.w400),
    title2: getOurTextStyle(22, 28),
    title: getOurTextStyle(20, 25),
    headline: getOurTextStyle(17, 22, weight: FontWeight.normal),
    subheadline: getOurTextStyle(15, 20),
    body: getOurTextStyle(17, 80, weight: FontWeight.normal),
    callout: getOurTextStyle(16, 21),
    footnote: getOurTextStyle(13, 18, weight: FontWeight.bold),
    caption: getOurTextStyle(12, 16),
    caption2: getOurTextStyle(11, 13),
  );
}

extension OurFontsExt on OurTypography {
  TextTheme getSimilarFlutterTextTheme() => const TextTheme(); // TODO:
}
