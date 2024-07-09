import 'package:app/extensions/hook.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef UseCubitHookConditionCallback<State> = bool Function(State before, State after);
typedef UseCubitHookStateGetterCallback<State, Value> = Value Function(State state);

S useCubit<T extends StateStreamable<S>, S>(
  UseCubitHookConditionCallback<S>? shouldUpdate,
) =>
    use(
      UseCubitHook<T, S>(
        shouldUpdate: shouldUpdate,
      ),
    );

class UseCubitHook<T extends StateStreamable<S>, S> extends Hook<S> {
  const UseCubitHook({required this.shouldUpdate});

  final UseCubitHookConditionCallback<S>? shouldUpdate;

  @override
  HookState<S, Hook<S>> createState() => UseCubitHookState<T, S>();
}

class UseCubitHookState<T extends StateStreamable<S>, S> extends HookState<S, UseCubitHook<T, S>> {
  late S _currentState;

  void _handleStateChange(S state) {
    final shouldUpdate = hook.shouldUpdate?.call(_currentState, state) ?? true;
    if (!shouldUpdate) return;
    _currentState = state;
    markNeedsBuild();
  }

  @override
  void initHook() {
    final cubit = context.read<T>();

    _currentState = cubit.state;
    cubit.stream.listen(_handleStateChange);

    super.initHook();
  }

  @override
  S build(BuildContext context) => _currentState;
}
