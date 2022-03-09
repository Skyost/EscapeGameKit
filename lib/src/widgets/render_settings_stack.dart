import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RenderSettingsStackWidget extends StatelessWidget {
  final RenderSettings? renderSettings;
  final Widget child;
  final Color? invisibleBackground;

  const RenderSettingsStackWidget({
    Key? key,
    this.renderSettings,
    required this.child,
    this.invisibleBackground = kDebugMode ? const Color(0x4DE91E63) : null,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    if (renderSettings == null) {
      return this.child;
    }

    Widget child = this.child;
    if (renderSettings!.isInvisible) {
      child = Visibility(
        child: child,
        visible: false,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        maintainInteractivity: true,
        maintainSemantics: true,
      );

      if ((invisibleBackground?.opacity ?? 0) != 0) {
        child = DecoratedBox(
          child: child,
          decoration: BoxDecoration(color: invisibleBackground),
        );
      }
    }

    if (renderSettings is PositionedRenderSettings) {
      return Positioned(
        top: renderSettings is PositionedRenderSettings ? (renderSettings as PositionedRenderSettings).top : 0,
        right: renderSettings is PositionedRenderSettings ? (renderSettings as PositionedRenderSettings).right : null,
        bottom: renderSettings is PositionedRenderSettings ? (renderSettings as PositionedRenderSettings).bottom : null,
        left: renderSettings is PositionedRenderSettings ? (renderSettings as PositionedRenderSettings).left : 0,
        width: renderSettings!.width,
        height: renderSettings!.height,
        child: child,
      );
    }

    return SizedBox(
      width: renderSettings!.width,
      height: renderSettings!.height,
      child: child,
    );
  }

  static ImageErrorWidgetBuilder? getImageErrorWidgetBuilder(RenderSettings? renderSettings) {
    if (renderSettings?.isInvisible == true) {
      return (context, error, stackTrace) => const SizedBox.expand();
    }
    return null;
  }
}
