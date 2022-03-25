

class RenderSettings {
  final double? width;
  final double? height;
  final double? rotationAngle;
  final String? asset;
  final bool isInvisible;

  const RenderSettings({
    this.width,
    this.height,
    this.rotationAngle,
    this.asset,
    bool? isInvisible,
  }) : isInvisible = isInvisible ?? asset == null;
}
