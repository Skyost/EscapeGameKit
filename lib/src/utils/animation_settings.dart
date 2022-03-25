import 'package:flutter/material.dart';

class AnimationSettings {
  final Duration duration;
  final Duration? reverseDuration;
  final Curve inCurve;
  final Curve outCurve;

  const AnimationSettings({
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
