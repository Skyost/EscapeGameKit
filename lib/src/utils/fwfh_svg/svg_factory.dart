import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'platform_specific/fallback.dart' if (dart.library.io) 'platform_specific/io.dart';

/// A mixin that can render SVG with `flutter_svg >= 2.0.0` plugin.
/// Thanks to [`fwfh_svg`](https://pub.dev/packages/fwfh_svg).
mixin SvgFactory on WidgetFactory {
  BuildOp? _tagSvg;

  /// Controls whether the SVG can be drawn outside
  /// of the clip boundary of its view box.
  /// See [SvgPicture.allowDrawingOutsideViewBox] for more information.
  ///
  /// Default: `false`.
  bool get svgAllowDrawingOutsideViewBox => false;

  @override
  Widget? buildImageWidget(BuildMetadata meta, ImageSource src) {
    final url = src.url;

    SvgLoader? svgLoader;
    if (url.startsWith('data:image/svg+xml')) {
      svgLoader = imageSvgFromDataUri(url);
    } else if (Uri.tryParse(url)?.path.toLowerCase().endsWith('.svg') == true) {
      if (url.startsWith('asset:')) {
        svgLoader = imageSvgFromAsset(url);
      } else if (url.startsWith('file:')) {
        svgLoader = imageSvgFromFileUri(url);
      } else {
        svgLoader = imageSvgFromNetwork(url);
      }
    }

    if (svgLoader == null) {
      return super.buildImageWidget(meta, src);
    }

    return _buildSvgPicture(meta, src, svgLoader);
  }

  /// Returns an [SvgAssetLoader].
  SvgLoader? imageSvgFromAsset(String url) {
    final uri = Uri.parse(url);
    final assetName = uri.path;
    if (assetName.isEmpty) {
      return null;
    }

    return SvgAssetLoader(
      assetName,
      packageName: uri.queryParameters['package'],
    );
  }

  /// Returns a [SvgBytesLoader].
  SvgLoader? imageSvgFromDataUri(String dataUri) {
    final bytes = bytesFromDataUri(dataUri);
    if (bytes == null) {
      return null;
    }

    return SvgBytesLoader(bytes);
  }

  /// Returns a [SvgFileLoader].
  SvgLoader? imageSvgFromFileUri(String url) {
    final filePath = Uri.parse(url).toFilePath();
    if (filePath.isEmpty) {
      return null;
    }

    return svgFileLoader(filePath);
  }

  /// Returns a [SvgNetworkLoader].
  SvgLoader? imageSvgFromNetwork(String url) {
    if (url.isEmpty) {
      return null;
    }

    return SvgNetworkLoader(url);
  }

  @override
  void parse(BuildMetadata meta) {
    switch (meta.element.localName) {
      case 'svg':
        _tagSvg ??= BuildOp(
          onWidgets: (meta, widgets) {
            final svgLoader = SvgStringLoader(meta.element.outerHtml);
            return [_buildSvgPicture(meta, const ImageSource(''), svgLoader)];
          },
        );
        meta.register(_tagSvg!);
        break;
    }

    return super.parse(meta);
  }

  Widget _buildSvgPicture(
    BuildMetadata meta,
    ImageSource src,
    SvgLoader svgLoader,
  ) {
    final image = src.image;
    final semanticLabel = image?.alt ?? image?.title;

    return SvgPicture(
      svgLoader,
      allowDrawingOutsideViewBox: svgAllowDrawingOutsideViewBox,
      excludeFromSemantics: semanticLabel == null,
      fit: BoxFit.fill,
      height: src.height,
      placeholderBuilder: (context) {
        final loading = onLoadingBuilder(context, meta, null, src);
        if (loading != null) {
          return loading;
        }

        if (src.width != null && src.height != null) {
          return SizedBox(width: src.width, height: src.height);
        }

        return SvgPicture.defaultPlaceholderBuilder(context);
      },
      semanticsLabel: semanticLabel,
      width: src.width,
    );
  }
}
