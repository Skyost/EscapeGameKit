import 'package:flutter/material.dart';

/// Allows to completely scale a widget based on a width and a height.
/// Thanks to [https://stasheq.medium.com/scale-whole-app-or-widget-contents-to-a-screen-size-in-flutter-e3be161b5ab4](Paweł Szymański).
class ScalingBox extends StatelessWidget {
  /// The base size.
  final Size baseSize;

  /// The child widget.
  final Widget child;

  /// Creates a new [ScalingBox] instance.
  const ScalingBox({
    super.key,
    required this.baseSize,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: baseSize.aspectRatio,
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox.fromSize(
              size: baseSize,
              child: child,
            ),
          ),
        ),
      );
}
