import 'package:flutter/material.dart';

class RoomTransition {
  final Duration duration;
  final Duration? reverseDuration;
  final Curve inCurve;
  final Curve outCurve;

  const RoomTransition({
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration,
    this.inCurve = Curves.linear,
    this.outCurve = Curves.linear,
  });

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
