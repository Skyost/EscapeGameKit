import 'dart:async';

import 'package:escape_game_kit/src/utils/number_extension.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/material.dart';

/// A little utility class that allows to create countdowns.
class Countdown with PropertiesEquatable {
  /// The countdown duration.
  final Duration duration;

  /// Number of seconds to subtract.
  final int secondsToSubtract;

  /// The countdown listeners.
  final List<CountdownListener> _listeners = [];

  /// Number of seconds to subtract currently (i.e. 0 if paused).
  late int _currentSecondsToSubtract;

  /// The current countdown remaining time.
  late Duration _currentDuration;

  /// The current timer.
  Timer? _timer;

  /// Creates a new countdown instance.
  Countdown({
    required this.duration,
    this.secondsToSubtract = 1,
  }) {
    cancel(fromConstructor: true);
  }

  /// Returns a copy of the instance listeners.
  List<CountdownListener> get listeners => List.of(_listeners);

  /// Adds a countdown listener to this instance.
  void addListener(CountdownListener listener) => _listeners.add(listener);

  /// Removes a countdown listener from this instance.
  void removeListener(CountdownListener listener) => _listeners.remove(listener);

  /// Clears all countdown listeners from this instance.
  void clearListeners() => _listeners.clear();

  /// Starts the countdown.
  void start() {
    _timer = Timer.periodic(Duration(seconds: secondsToSubtract), (timer) {
      if (_currentSecondsToSubtract == 0) {
        return;
      }

      int seconds = _currentDuration.inSeconds - _currentSecondsToSubtract;
      if (seconds <= 0) {
        cancel();
        for (CountdownListener listener in listeners) {
          listener.onTick(Duration.zero);
        }
        return;
      }

      _currentDuration = Duration(seconds: seconds);
      for (CountdownListener listener in listeners) {
        listener.onTick(_currentDuration);
      }
    });
    for (CountdownListener listener in listeners) {
      listener.onStarted();
    }
  }

  /// Returns whether this countdown is started.
  bool get isStarted => _timer != null;

  /// Returns whether this countdown is paused.
  bool get isPaused => _currentSecondsToSubtract == 0;

  /// Resumes this countdown.
  void resume() {
    _currentSecondsToSubtract = secondsToSubtract;
    for (CountdownListener listener in listeners) {
      listener.onResumed();
    }
  }

  /// Pauses this countdown.
  void pause() {
    _currentSecondsToSubtract = 0;
    for (CountdownListener listener in listeners) {
      listener.onPaused();
    }
  }

  /// Chancels this countdown.
  void cancel({bool fromConstructor = false}) {
    _timer?.cancel();
    _timer = null;
    _currentDuration = duration;
    _currentSecondsToSubtract = secondsToSubtract;
    if (!fromConstructor) {
      for (CountdownListener listener in listeners) {
        listener.onCancelled();
      }
    }
  }

  @override
  @protected
  List<Object?> get props => [duration, secondsToSubtract, _currentSecondsToSubtract, _currentDuration, _timer];
}

/// Represents a countdown listener that can react to various countdown events.
mixin CountdownListener {
  /// Triggered when the countdown has started.
  void onStarted() {}

  /// Triggered when the countdown has updated its current duration.
  void onTick(Duration currentDuration) {}

  /// Triggered when the countdown has paused.
  void onPaused() {}

  /// Triggered when the countdown has resumed.
  void onResumed() {}

  /// Triggered when the countdown was cancelled.
  void onCancelled() {}
}

/// Allows to display a countdown.
class CountdownWidget extends StatefulWidget {
  /// The countdown.
  final Countdown countdown;

  /// The widget text style.
  final TextStyle? textStyle;

  /// The widget text align.
  final TextAlign? textAlign;

  /// Creates a new countdown widget instance.
  const CountdownWidget({
    Key? key,
    required this.countdown,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountdownWidgetState();
}

/// The countdown widget state.
class _CountdownWidgetState extends State<CountdownWidget> with AutomaticKeepAliveClientMixin, CountdownListener {
  /// The countdown current duration.
  Duration? currentDuration;

  @override
  void initState() {
    super.initState();

    currentDuration = widget.countdown.duration;
    widget.countdown.addListener(this);
    if (!widget.countdown.isStarted) {
      widget.countdown.start();
    }
  }

  @override
  void didUpdateWidget(CountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    oldWidget.countdown.removeListener(this);
    widget.countdown.addListener(this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int minutes = currentDuration?.inMinutes ?? 0;
    int seconds = (currentDuration?.inSeconds ?? 0) % 60;
    return Text(
      '${minutes.withLeadingZero}:${seconds.withLeadingZero}',
      style: widget.textStyle,
      textAlign: widget.textAlign,
    );
  }

  @override
  void dispose() {
    widget.countdown.removeListener(this);
    super.dispose();
  }

  @override
  void onTick(Duration currentDuration) {
    if (mounted) {
      setState(() => this.currentDuration = currentDuration);
    }
  }

  @override
  bool get wantKeepAlive => currentDuration != widget.countdown.duration;
}
