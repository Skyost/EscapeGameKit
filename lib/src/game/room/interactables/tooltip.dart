import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/material.dart';

/// Represents a displayable tooltip.
class InteractableTooltip with PropertiesEquatable {
  /// The tooltip text.
  final String text;

  /// Controls how this tooltip should be shifted in the `x` coordinate.
  final double xShift;

  /// Controls how this tooltip should be shifted in the `y` coordinate.
  final double yShift;

  /// Creates a new [InteractableTooltip] instance.
  const InteractableTooltip({
    required this.text,
    this.xShift = 1,
    this.yShift = 1,
  });

  /// Calculates the `x` coordinate according to the provided [mousePosition].
  double calculateX(Offset mousePosition) => mousePosition.dx + xShift;

  /// Calculates the `y` coordinate according to the provided [mousePosition].
  double calculateY(Offset mousePosition) => mousePosition.dy + yShift;

  @override
  @protected
  List<Object?> get props => [text, xShift, yShift];
}
