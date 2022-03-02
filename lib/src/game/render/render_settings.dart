class RenderSettings {
  final double? width;
  final double? height;
  final String? asset;
  final bool isInvisible;

  const RenderSettings({
    this.width,
    this.height,
    this.asset,
    bool? isInvisible,
  }) : isInvisible = isInvisible ?? asset == null;
}
