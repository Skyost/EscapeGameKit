import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that either display a SVG or a more classic image.
class AutoImage extends StatefulWidget {
  /// The image asset.
  final String asset;

  /// The image width.
  final double? width;

  /// The image height.
  final double? height;

  /// The error builder.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Creates a new [AutoImage] instance.
  const AutoImage({
    Key? key,
    required this.asset,
    required this.width,
    required this.height,
    this.errorBuilder,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _AutoImageState();
}

/// The [AutoImage] state.
class _AutoImageState extends State<AutoImage> {
  /// Whether the currently displayed SVG is loading.
  late bool isSvgLoading;

  /// The SVG loading error.
  Object? svgError;

  /// The SVG loading error stacktrace.
  StackTrace? svgStackTrace;

  @override
  void initState() {
    super.initState();
    isSvgLoading = isSvg;
    if (isSvg) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        await precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, widget.asset),
          context,
          onError: (error, stacktrace) {
            setState(() {
              svgError = error;
              svgStackTrace = stacktrace;
            });
          },
        );
        setState(() => isSvgLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSvgLoading) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
      );
    }
    if (svgError != null && svgStackTrace != null && widget.errorBuilder != null) {
      return widget.errorBuilder!(context, svgError!, svgStackTrace);
    }
    return isSvg
        ? SvgPicture.asset(
            widget.asset,
            width: widget.width,
            height: widget.height,
          )
        : Image.asset(
            widget.asset,
            width: widget.width,
            height: widget.height,
            errorBuilder: widget.errorBuilder,
          );
  }

  /// Returns whether the asset is a SVG.
  bool get isSvg => widget.asset.endsWith('.svg');
}
