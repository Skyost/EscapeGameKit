import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/utils/animation_settings.dart';
import 'package:flutter/material.dart';

class InteractableRenderSettings extends PositionedRenderSettings {
  final AnimationSettings? hoverAnimationSettings;
  final Matrix4? hoverTransformation;

  const InteractableRenderSettings({
    double? top,
    double? right,
    double? bottom,
    double? left,
    double? width,
    double? height,
    double? rotationAngle,
    String? asset,
    bool? isInvisible,
    this.hoverAnimationSettings,
    this.hoverTransformation,
  }) : super(
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          width: width,
          height: height,
          rotationAngle: rotationAngle,
          asset: asset,
          isInvisible: isInvisible,
        );
}
