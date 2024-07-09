import 'dart:async';

import 'package:app/services/alert_service_state.dart';
import 'package:app/utils/our_cubit.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AlertService extends OurCubit<AlertServiceState> {
  AlertService() : super(AlertServiceState());

  /// A map that holds timers that automatically
  /// remove the alert from state.
  Map<String, Timer> _timers = <String, Timer>{};

  void dismiss(AlertEntry entry) {
    // A late timer may call dismiss after the service is disposed,
    // but at that point there's nothing to do anymore.
    if (isClosed) return;

    final timer = _timers.remove(entry.key);
    timer?.cancel();
    state = state.copyWith(
      alerts: state.alerts.where((e) => e != entry).toList(growable: false),
    );
  }

  void notify(Alert alert) {
    final key = "RANDOMIZE_THIS_STRING_${DateTime.now().millisecondsSinceEpoch}";
    final entry = AlertEntry(key: key, alert: alert);

    state = state.copyWith(alerts: state.alerts + [entry]);

    assert(!_timers.containsKey(key));
    if ((alert.duration ?? Duration.zero) > Duration.zero) {
      _timers[key] = Timer(alert.duration!, () => dismiss(entry));
    }
  }

  @disposeMethod
  @override
  Future<void> close() {
    final oldTimers = _timers;
    _timers = {};

    for (final value in oldTimers.values) {
      value.cancel();
    }

    return super.close();
  }
}
