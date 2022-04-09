import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that either display a SVG or a more classic image.
class AutoImage extends StatelessWidget {
  /// The image asset.
  final String? asset;

  /// The image width.
  final double? width;

  /// The image height.
  final double? height;

  /// Creates a new [AutoImage] instance.
  const AutoImage({
    Key? key,
    required this.asset,
    required this.width,
    required this.height,
  }) : super(
          key: key,
        );

  /// Creates a new [AutoImage] instance from the specified [renderSettings].
  AutoImage.fromRenderSettings({
    Key? key,
    RenderSettings? renderSettings,
    String? defaultAssetPath,
  }) : this(
          key: key,
          asset: renderSettings?.asset ?? defaultAssetPath,
          height: renderSettings?.height,
          width: renderSettings?.width,
        );

  @override
  Widget build(BuildContext context) {
    if (asset == null) {
      return SizedBox(
        width: width,
        height: height,
      );
    }
    return isSvg
        ? SvgPicture.asset(
            asset!,
            width: width,
            height: height,
          )
        : Image.asset(
            asset!,
            width: width,
            height: height,
          );
  }

  /// Returns whether the asset is a SVG.
  bool get isSvg => asset != null && asset!.endsWith('.svg');
}
