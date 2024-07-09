import 'dart:async';

import 'package:app/extensions/hook.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef UseCubitValueConditionCallback<Value, State> = Value Function(State s);

V useValue<S, V>(
  StateStreamable<S> cubit,
  UseCubitValueConditionCallback<V, S> getValue,
) =>
    use(
      UseCubitValueHook<S, V>(
        cubit: cubit,
        getValue: getValue,
      ),
    );

class UseCubitValueHook<S, V> extends Hook<V> {
  const UseCubitValueHook({
    required this.cubit,
    required this.getValue,
  });

  final StateStreamable<S> cubit;
  final UseCubitValueConditionCallback<V, S> getValue;

  @override
  HookState<V, Hook<V>> createState() => UseCubitValueHookState<S, V>();
}

class UseCubitValueHookState<S, V> extends HookState<V, UseCubitValueHook<S, V>> {
  late StreamSubscription<S> _subscription;
  late V _lastValue;

  void _handleStateChange(S state) {
    final newValue = hook.getValue(state);
    if (_lastValue == newValue) return;
    _lastValue = newValue;
    markNeedsBuild();
  }

  @override
  void initHook() {
    _lastValue = hook.getValue(hook.cubit.state);
    _subscription = hook.cubit.stream.listen(_handleStateChange);

    super.initHook();
  }

  @override
  void didUpdateHook(UseCubitValueHook<S, V> oldHook) {
    bool shouldHandleStateChange = false;

    if (oldHook.cubit != hook.cubit) {
      _subscription.cancel();
      _subscription = hook.cubit.stream.listen(_handleStateChange);
      shouldHandleStateChange = true;
    }

    if (oldHook.getValue != hook.getValue) shouldHandleStateChange = true;
    if (shouldHandleStateChange) _handleStateChange(hook.cubit.state);

    super.didUpdateHook(oldHook);
  }

  @override
  void reassemble() {
    _handleStateChange(hook.cubit.state);
    super.reassemble();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  V build(BuildContext context) => _lastValue;
}
