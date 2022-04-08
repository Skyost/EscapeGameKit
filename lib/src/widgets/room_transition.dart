import 'package:flutter/material.dart';

/// Controls the transition between two rooms.
class RoomTransition {
  /// The transition duration.
  final Duration duration;

  /// The transition reverse duration.
  final Duration? reverseDuration;

  /// The transition in curve.
  final Curve inCurve;

  /// The transition out curve.
  final Curve outCurve;

  /// Creates a new [RoomTransition] instance.
  const RoomTransition({
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration,
    this.inCurve = Curves.linear,
    this.outCurve = Curves.linear,
  });

  /// Creates an [AnimatedSwitcher] widget instance.
  Widget createAnimatedSwitch({
    required Widget child,
    AnimatedSwitcherTransitionBuilder transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
  }) =>
      AnimatedSwitcher(
        transitionBuilder: transitionBuilder,
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: inCurve,
        switchOutCurve: outCurve,
        child: child,
      );
}
