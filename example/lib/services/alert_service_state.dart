import 'package:app/design/colors.dart';
import 'package:app/services/alert_service.dart';
import 'package:app/utils/errors.dart';
import 'package:app/utils/locate.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "alert_service_state.freezed.dart";

@freezed
class AlertServiceState with _$AlertServiceState {
  AlertServiceState._();

  factory AlertServiceState({
    @Default([]) List<AlertEntry> alerts,
  }) = _AlertServiceState;

  //

  /// This is the alert that should be displayed onscreen.
  late final lastEntry = alerts.lastOrNull;
}

@freezed
class AlertEntry with _$AlertEntry {
  const AlertEntry._();

  const factory AlertEntry({
    required String key,
    required Alert alert,
  }) = _AlertEntry;

  void dismiss() => locate<AlertService>().dismiss(this);
}

@freezed
class Alert with _$Alert {
  const Alert._();

  /// The default duration of how long the alert should be displayed onscreen.
  static const defaultDuration = Duration(seconds: 5);

  const factory Alert.error(
    String title,
    String caption, {
    @Default(Alert.defaultDuration) Duration? duration,
  }) = _AlertError;

  const factory Alert.message(
    String title,
    String caption, {
    @Default(Alert.defaultDuration) Duration? duration,
  }) = _AlertMessage;

  const factory Alert.unimplementedTemplate({
    @Default(Alert.defaultDuration) Duration? duration,
  }) = _AlertUnimplementedTemplate;

  //

  void notify() => locate<AlertService>().notify(this);

  String get title => map(
        error: (v) => v.title,
        message: (v) => v.title,
        unimplementedTemplate: (_) => "Just a Template",
      );

  String get caption => map(
        error: (v) => v.caption,
        message: (v) => v.caption,
        unimplementedTemplate: (_) => "This functionality is not implemented.",
      );

  Color? getPreferredBackgroundColorFrom(OurColors colors) => mapOrNull(error: (_) => colors.error);
  Color? getPreferredContentColorFrom(OurColors colors) => mapOrNull(error: (_) => colors.onError);

  /// Attempts to get the message out of the [error] object or uses our default.
  ///
  /// May return null when no alert is intended for this error, like if it's a [CancelledError].
  static Alert? getErrorFor(Object error, {Duration? duration}) {
    final String? message = switch (error) {
      CancelledError _ => null,
      _ => null,
    };

    return Alert.error(
      "Uh-oh!",
      message ?? "Something went wrong and we don't know what.",
      duration: duration ?? Alert.defaultDuration,
    );
  }
}
