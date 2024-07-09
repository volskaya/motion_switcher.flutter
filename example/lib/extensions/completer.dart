import 'dart:async';

extension CompleterExt<T> on Completer<T> {
  /// Completes [future] with the supplied values.
  /// If called more than once, this function does not throw.
  void completeSafe([FutureOr<T>? value]) {
    if (isCompleted) return;
    try {
      complete(value);
    } catch (_) {}
  }

  void completeErrorSafe(Object error, [StackTrace? stackTrace]) {
    if (isCompleted) return;
    try {
      completeError(error, stackTrace);
    } catch (_) {}
  }
}
