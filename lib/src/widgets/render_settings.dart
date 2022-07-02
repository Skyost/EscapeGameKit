import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Builds a widget that corresponds to the given [renderSettings].
class RenderSettingsWidget extends StatelessWidget {
  /// The render settings.
  final RenderSettings? renderSettings;

  /// The child widget.
  final Widget child;

  /// The invisible background.
  final Color? invisibleBackground;

  /// Creates a new [RenderSettingsWidget] instance.
  const RenderSettingsWidget({
    super.key,
    this.renderSettings,
    required this.child,
    this.invisibleBackground = kDebugMode ? const Color(0x4DE91E63) : null,
  });

  @override
  Widget build(BuildContext context) {
    if (renderSettings == null) {
      return this.child;
    }

    Widget child = this.child;
    if (renderSettings!.rotationAngle != null) {
      child = Transform.rotate(
        angle: renderSettings!.rotationAngle!,
        child: child,
      );
    }

    if (renderSettings!.mirror) {
      child = Transform.scale(
        scaleX: -1,
        child: child,
      );
    }

    if (renderSettings!.isInvisible) {
      child = Visibility(
        visible: false,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        maintainInteractivity: true,
        maintainSemantics: true,
        child: child,
      );

      if ((invisibleBackground?.opacity ?? 0) != 0) {
        child = DecoratedBox(
          decoration: BoxDecoration(color: invisibleBackground),
          child: child,
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
}
