import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Controls how an object should be rendered in the game.
class RenderSettings with PropertiesEquatable {
  /// The width.
  final double? width;

  /// The height.
  final double? height;

  /// The rotation angle.
  final double? rotationAngle;

  /// Whether to mirror the asset.
  final bool mirror;

  /// The asset to display.
  final String? asset;

  /// Whether this object should be invisible.
  final bool isInvisible;

  /// Creates a new [RenderSettings] instance.
  const RenderSettings({
    this.width,
    this.height,
    this.rotationAngle,
    this.mirror = false,
    this.asset,
    bool? isInvisible,
  }) : isInvisible = isInvisible ?? asset == null;

  @override
  @protected
  List<Object?> get props => [width, height, rotationAngle, asset, isInvisible];
}
