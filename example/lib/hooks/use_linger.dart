import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Doesn't let the value turn null, until [keepLinger] is false.
///
/// If [value] == null, this will linger the previous value.
T? useLinger<T>(T value, {bool keepLingering = true}) => use(
      _Hook<T>(
        value: value,
        keepLingering: keepLingering,
      ),
    );

class _Hook<T> extends Hook<T?> {
  const _Hook({
    required this.value,
    required this.keepLingering,
  });

  final T value;
  final bool keepLingering;

  @override
  HookState<T?, Hook<T?>> createState() => _HookState<T>();
}

class _HookState<T> extends HookState<T?, _Hook<T?>> {
  late T? _lingeredValue = hook.value;

  @override
  void didUpdateHook(_Hook<T?> oldHook) {
    if (oldHook.value != hook.value || oldHook.keepLingering != hook.keepLingering) {
      if (!hook.keepLingering || hook.value != null) {
        _lingeredValue = hook.value;
      }
    }
    super.didUpdateHook(oldHook);
  }

  @override
  void dispose() {
    _lingeredValue = null;
    super.dispose();
  }

  @override
  T? build(BuildContext context) => _lingeredValue;
}
