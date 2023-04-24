import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

/// Allows to display a nice and coherent "Object found !" dialog.
class ObjectFoundDialogContent extends StatelessWidget {
  /// The asset.
  final String asset;

  /// The width.
  final double? width;

  /// The height.
  final double? height;

  /// The message.
  final String message;

  /// Creates a new object found dialog content instance.
  const ObjectFoundDialogContent({
    super.key,
    required this.asset,
    this.width,
    this.height = 100,
    required this.message,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SvgPicture.asset(
              asset,
              width: width,
              height: height,
            ),
          ),
          HtmlWidget(
            '<div align="center">$message</div>',
            textStyle: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      );
}
