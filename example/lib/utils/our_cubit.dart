import 'dart:async';

import 'package:app/extensions/completer.dart';
import 'package:app/hooks/use_cubit_value.dart';
import 'package:app/utils/locate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A shortcut to locating our cubits and wrapping them in a [BlocProvider].
BlocProvider<T> locateAndWrapBlocProvider<T extends OurCubit>() => BlocProvider.value(value: locate<T>());

/// {@template cubit}
///
/// [OurCubit] extends Bloc's [Cubit] with our own custom utilities.
///
/// A [OurCubit] is similar to [Bloc] but has no notion of events
/// and relies on methods to [emit] new states.
///
/// Every [OurCubit] requires an initial state which will be the
/// state of the [OurCubit] before [emit] has been called.
///
/// The current state of a [OurCubit] can be accessed via the [state] getter.
///
/// ```dart
/// class CounterCubit extends OurCubit<int> {
///   CounterCubit() : super(0);
///
///   void increment() => emit(state + 1);
/// }
/// ```
///
/// {@endtemplate}
abstract class OurCubit<State> extends Cubit<State> {
  /// {@macro cubit}
  OurCubit(super.initialState);

  /// A shortcut for creating [BlocProvider] of this cubit.
  BlocProvider<T> createBlocProvider<T extends OurCubit<State>>() => BlocProvider<T>.value(value: this as T);

  /// {@template OurCubit.observe}
  ///
  /// Observes the value derived from [State] with [getValue].
  ///
  /// Other changes to [State] won't cause the widget to update, unless the [V] itself changed.
  ///
  /// **This is a hook, so must be built in a [HookWidget] or [HookBuilder].**
  ///
  /// {@endtemplate}
  V observe<V>(UseCubitValueConditionCallback<V, State> getValue) => useValue(this, getValue);

  /// Updates the [state] to the provided [state].
  /// [emit] does nothing if the [state] being emitted
  /// is equal to the current [state].
  ///
  /// To allow for the possibility of notifying listeners of the initial state,
  /// emitting a state which is equal to the initial state is allowed as long
  /// as it is the first thing emitted by the instance.
  ///
  /// * Throws a [StateError] if the bloc is closed.
  set state(State value) => emit(value);

  /// Awaits this cubit until [condition] becomes truthy.
  Future<bool> awaitState(
    bool? Function(State state) condition, {
    Duration? timeout,
  }) {
    final isAlreadyTruthy = condition(state) == true;

    // Check if the [condition] is already truthy or the bloc is closed.
    if (isAlreadyTruthy || isClosed) {
      return Future.sync(() => isAlreadyTruthy);
    } else {
      StreamSubscription<State>? subscription;
      final completer = Completer<bool>();

      void handleComplete([bool? conditionWasTruthy]) {
        if (completer.isCompleted) return;

        subscription?.cancel();
        completer.completeSafe(conditionWasTruthy == true);
      }

      subscription = stream.listen((state) {
        if (condition(state) == true) handleComplete(true);
      })
        // Bloc was closed or the subscription was canceled.
        ..onDone(handleComplete)
        ..onError((_, __) => handleComplete());

      if ((timeout ?? Duration.zero) > Duration.zero) {
        assert(timeout! > Duration.zero);
        Timer(timeout!, handleComplete);
      }

      return completer.future.whenComplete(subscription.cancel);
    }
  }
}
