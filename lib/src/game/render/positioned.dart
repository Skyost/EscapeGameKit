import 'package:escape_game_kit/src/game/render/render_settings.dart';

class PositionedRenderSettings extends RenderSettings {
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  const PositionedRenderSettings({
    this.top,
    this.right,
    this.bottom,
    this.left,
    double? width,
    double? height,
    double? rotationAngle,
    String? asset,
    bool? isInvisible,
  }) : super(
          width: width,
          height: height,
          rotationAngle: rotationAngle,
          asset: asset,
          isInvisible: isInvisible,
        );
}
