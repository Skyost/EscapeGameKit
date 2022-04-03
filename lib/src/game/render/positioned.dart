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
  int get hashCode => super.hashCode + top.hashCode + right.hashCode + bottom.hashCode + left.hashCode;
}
