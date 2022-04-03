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

  @override
  bool operator ==(Object other) {
    if (other is! RenderSettings) {
      return super == other;
    }
    return identical(this, other) || (width == other.width && height == other.height && rotationAngle == other.rotationAngle && asset == other.asset && isInvisible == other.isInvisible);
  }

  @override
  int get hashCode => width.hashCode + height.hashCode + rotationAngle.hashCode + asset.hashCode + isInvisible.hashCode;
}
