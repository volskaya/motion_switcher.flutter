import 'package:app/hooks/use_cubit_value.dart';
import 'package:app/utils/our_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final $$ = GetIt.instance;

extension BuildContextDollarSigns on BuildContext {
  T $$<T>() => read<T>();
  T $<T>() => watch<T>();
}

extension OurCubbitDollarSigns<State> on OurCubit<State> {
  /// {@macro OurCubit.observe}
  ///
  /// Shortcut for [observe] - 6 less characters in a line.
  V $<V>(UseCubitValueConditionCallback<V, State> getValue) => useValue(this, getValue);
}
