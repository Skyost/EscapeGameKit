import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AutoImage extends StatefulWidget {
  final String asset;
  final double? width;
  final double? height;
  final ImageErrorWidgetBuilder? errorBuilder;

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

class _AutoImageState extends State<AutoImage> {
  late bool isSvgLoading;
  Object? svgError;
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

  bool get isSvg => widget.asset.endsWith('.svg');
}
