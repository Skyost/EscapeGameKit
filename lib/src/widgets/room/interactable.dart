import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/utils/assets_extension.dart';
import 'package:escape_game_kit/src/utils/auto_image.dart';
import 'package:escape_game_kit/src/widgets/padlocks/dialogs.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:escape_game_kit/src/widgets/room/interactable_animation.dart';
import 'package:flutter/material.dart';

class InteractableWidget extends StatefulWidget {
  final EscapeGame escapeGame;
  final Interactable interactable;

  InteractableWidget({
    Key? key,
    required this.escapeGame,
    required this.interactable,
  }) : super(
          key: key ?? ValueKey<String>('interactable-${interactable.id}'),
        );

  @override
  State<StatefulWidget> createState() => _InteractableWidgetState();

  @protected
  Future<void> onInteractableTapped(BuildContext context) async {
    ActionResult result = interactable.onTap(escapeGame);
    if (result.state == ActionResultState.needAction && result.object is Padlock) {
      await (result.object as Padlock).tryUnlockViaDialog(context);
      if ((result.object as Padlock).state.isUnlocked) {
        interactable.onTap(escapeGame);
      }
    }
  }
}

class _InteractableWidgetState extends State<InteractableWidget> {
  double tooltipOpacity = 0;
  OverlayEntry? tooltipOverlayEntry;
  Offset? tooltipPosition;
  AnimationController? hoverAnimationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      refreshState();
      widget.interactable.addListener(refreshState);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (widget.interactable.isDestroyed) {
      result = const SizedBox.shrink();
    }

    Widget image = AutoImage(
      asset: widget.interactable.renderSettings?.asset ?? widget.interactable.defaultAssetPath,
      width: widget.interactable.renderSettings?.width,
      height: widget.interactable.renderSettings?.height,
      errorBuilder: RenderSettingsStackWidget.getImageErrorWidgetBuilder(widget.interactable.renderSettings),
    );

    String? tooltip = widget.interactable.onTooltip(widget.escapeGame).object;
    result = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        if (tooltip != null) {
          showTooltip(event);
        }
        hoverAnimationController?.forward(from: widget.interactable.renderSettings?.hoverAnimation?.from);
      },
      onHover: (event) {
        if (tooltip != null) {
          updateTooltipPosition(event);
        }
      },
      onExit: (event) {
        if (tooltip != null) {
          hideTooltip(event);
        }
        hoverAnimationController?.reset();
      },
      child: Listener(
        onPointerUp: (event) => widget.onInteractableTapped(context),
        behavior: HitTestBehavior.translucent,
        child: InteractableAnimationWidget(
          animation: widget.interactable.renderSettings?.enterAnimation,
          child: InteractableAnimationWidget(
            animation: widget.interactable.renderSettings?.hoverAnimation,
            child: image,
            controller: (controller) => hoverAnimationController = controller,
            animate: false,
          ),
        ),
      ),
    );

    return result;
  }

  @override
  void dispose() {
    if (tooltipOpacity != 0) {
      tooltipOverlayEntry?.remove();
    }
    widget.interactable.removeListener(refreshState);
    super.dispose();
  }

  void showTooltip(PointerEvent event) {
    updateTooltipPosition(event);
    tooltipOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: tooltipPosition!.dy + 1,
        left: tooltipPosition!.dx + 1,
        child: AnimatedOpacity(
          opacity: tooltipOpacity,
          duration: const Duration(milliseconds: 200),
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black54,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                widget.interactable.onTooltip(widget.escapeGame).object!,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      opaque: false,
    );
    Overlay.of(context)?.insert(tooltipOverlayEntry!);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      tooltipOpacity = 1;
      tooltipOverlayEntry?.markNeedsBuild();
    });
  }

  void updateTooltipPosition(PointerEvent event) {
    Offset? previousPosition = tooltipPosition;
    tooltipPosition = Offset(event.position.dx, event.position.dy);
    if (previousPosition != tooltipPosition) {
      tooltipOverlayEntry?.markNeedsBuild();
    }
  }

  Future<void> hideTooltip(PointerEvent event) async {
    OverlayEntry? tooltipOverlayEntry = this.tooltipOverlayEntry;
    if (tooltipOverlayEntry != null) {
      tooltipOpacity = 0;
      tooltipOverlayEntry.markNeedsBuild();
      await Future.delayed(const Duration(milliseconds: 200));
      tooltipOverlayEntry.remove();
    }
  }

  void refreshState() {
    if (mounted) {
      setState(() {});
    }
  }
}
