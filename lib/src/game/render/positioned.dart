import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:flutter/foundation.dart';

/// Controls how an object should be rendered and positioned in the game.
class PositionedRenderSettings extends RenderSettings {
  /// The top position.
  final double? top;

  /// The right position.
  final double? right;

  /// The bottom position.
  final double? bottom;

  /// The left position.
  final double? left;

  /// Creates a new [PositionedRenderSettings] instance.
  const PositionedRenderSettings({
    this.top,
    this.right,
    this.bottom,
    this.left,
    super.width,
    super.height,
    super.rotationAngle,
    super.mirror,
    super.asset,
    super.isInvisible,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is RenderSettings) {
      if (super != other) {
        return false;
      }

      if (other is! PositionedRenderSettings) {
        return top == null && right == null && bottom == null && left == null;
      }
      return top == other.top && right == other.right && bottom == other.bottom && left == other.left;
    }
    return super == other;
  }

  @override
  @protected
  List<Object?> get props => [...super.props, width, height, rotationAngle, asset, isInvisible];
}
