import 'dart:io';

import 'package:app/design/tokens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurProgressIndicator extends StatelessWidget {
  const OurProgressIndicator({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoActivityIndicator(color: color);
    }

    // We prefer a smaller indicator for our design.
    return SizedBox(
      width: Dimensions.xs,
      height: Dimensions.xs,
      child: CircularProgressIndicator(color: color),
    );
  }
}
