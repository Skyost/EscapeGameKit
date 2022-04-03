import 'package:flutter/material.dart';

class InteractableTooltip {
  final String text;
  final double yShift;
  final double xShift;

  const InteractableTooltip({
    required this.text,
    this.yShift = 1,
    this.xShift = 1,
  });

  double calculateTopPosition(Offset mousePosition) => mousePosition.dy + yShift;

  double calculateLeftPosition(Offset mousePosition) => mousePosition.dx + xShift;

  @override
  bool operator ==(Object other) {
    if (other is! InteractableTooltip) {
      return super == other;
    }
    return identical(this, other) || (text == other.text && yShift == other.yShift && xShift == other.xShift);
  }

  @override
  int get hashCode => text.hashCode + yShift.hashCode + xShift.hashCode;
}
