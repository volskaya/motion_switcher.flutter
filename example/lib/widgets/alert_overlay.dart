import 'package:app/design/colors.dart';
import 'package:app/design/tokens.dart';
import 'package:app/design/typography.dart';
import 'package:app/services/alert_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:motion_switcher/motion_switcher.dart';

class AlertOverlay extends HookWidget {
  const AlertOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = OurColors.of(context);
    final typography = OurTypography.of(context);
    final safeArea = MediaQuery.paddingOf(context);

    final alertEntry = context.read<AlertService>().observe((s) => s.lastEntry);
    final backgroundColor = alertEntry?.alert.getPreferredBackgroundColorFrom(colors) ?? colors.surface;
    final contentColor = alertEntry?.alert.getPreferredContentColorFrom(colors) ?? colors.onSurface;

    return DefaultTextStyle(
      style: typography.title.copyWith(color: colors.onSurface),
      child: MotionSwitcher(
        alignment: Alignment.topCenter,
        child: alertEntry != null
            ? GestureDetector(
                key: ValueKey(alertEntry.key),
                onTap: alertEntry.dismiss,
                child: Container(
                  margin: Paddings.xs + safeArea,
                  padding: Paddings.xs,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadii.button,
                    color: backgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        alertEntry.alert.title,
                        style: typography.title2.copyWith(color: contentColor),
                      ),
                      Text(
                        alertEntry.alert.caption,
                        style: typography.caption.copyWith(color: contentColor),
                      )
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
