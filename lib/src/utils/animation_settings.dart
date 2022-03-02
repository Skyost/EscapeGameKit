import 'package:flutter/material.dart';

class AnimationSettings {
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  const AnimationSettings({
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
  });

  Widget createAnimatedSwitch({
    required Widget child,
  }) =>
      AnimatedSwitcher(
        transitionBuilder: transitionBuilder,
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        child: child,
      );
}
