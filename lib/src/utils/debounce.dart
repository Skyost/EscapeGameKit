import 'dart:async';

/// Thanks to the [easy_debounce](https://pub.dev/packages/easy_debounce) library.

/// A void callback, i.e. (){}, so we don't need to import e.g. `dart.ui`
/// just for the VoidCallback type definition.
typedef DebounceCallback = void Function();

class _DebounceOperation {
  DebounceCallback callback;
  Timer timer;
  _DebounceOperation(this.callback, this.timer);
}

/// A static class for handling method call debouncing.
class Debouncer {
  static Map<String, _DebounceOperation> _operations = {};

  /// Will delay the execution of [onExecute] with the given [duration]. If another call to
  /// debounce() with the same [tag] happens within this duration, the first call will be
  /// cancelled and the debouncer will start waiting for another [duration] before executing
  /// [onExecute].
  ///
  /// [tag] is any arbitrary String, and is used to identify this particular debounce
  /// operation in subsequent calls to [debounce()] or [cancel()].
  ///
  /// If [duration] is `Duration.zero`, [onExecute] will be executed immediately, i.e.
  /// synchronously.
  static void debounce(
      String tag, Duration duration, DebounceCallback onExecute) {
    if (duration == Duration.zero) {
      _operations[tag]?.timer.cancel();
      _operations.remove(tag);
      onExecute();
    } else {
      _operations[tag]?.timer.cancel();

      _operations[tag] = _DebounceOperation(
          onExecute,
          Timer(duration, () {
            _operations[tag]?.timer.cancel();
            _operations.remove(tag);

            onExecute();
          }));
    }
  }

  /// Fires the callback associated with [tag] immediately. This does not cancel the debounce timer,
  /// so if you want to invoke the callback and cancel the debounce timer, you must first call
  /// `fire(tag)` and then `cancel(tag)`.
  static void fire(String tag) {
    _operations[tag]?.callback();
  }

  /// Cancels any active debounce operation with the given [tag].
  static void cancel(String tag) {
    _operations[tag]?.timer.cancel();
    _operations.remove(tag);
  }

  /// Cancels all active debouncers.
  static void cancelAll() {
    for (final operation in _operations.values) {
      operation.timer.cancel();
    }
    _operations.clear();
  }

  /// Returns the number of active debouncers (debouncers that haven't yet called their
  /// [onExecute] methods).
  static int count() {
    return _operations.length;
  }
}
