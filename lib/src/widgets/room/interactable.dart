import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';
import 'package:escape_game_kit/src/utils/auto_image.dart';
import 'package:escape_game_kit/src/widgets/padlocks/dialogs.dart';
import 'package:escape_game_kit/src/widgets/room/interactable_animation.dart';
import 'package:flutter/material.dart';

/// Allows to render an [Interactable].
class InteractableWidget extends StatefulWidget {
  /// The [EscapeGame] instance.
  final EscapeGame escapeGame;

  /// The interactable.
  final Interactable interactable;

  /// Creates a new [InteractableWidget] instance.
  InteractableWidget({
    Key? key,
    required this.escapeGame,
    required this.interactable,
  }) : super(
          key: key ?? ValueKey<String>('interactable-${interactable.id}'),
        );

  @override
  State<StatefulWidget> createState() => _InteractableWidgetState();

  /// Triggered when the [interactable] has been tapped on.
  @protected
  Future<void> onInteractableTapped(BuildContext context) async {
    ActionResult result = interactable.onTap(escapeGame);
    if (result.state == ActionResultState.needAction && result.object is Padlock) {
      await (result.object as Padlock).tryUnlockViaDialog(context);
      if ((result.object as Padlock).isUnlocked) {
        interactable.onTap(escapeGame);
      }
    }
  }
}

/// The [InteractableWidget] state.
class _InteractableWidgetState extends State<InteractableWidget> {
  /// The current tooltip opacity.
  double tooltipOpacity = 0;

  /// The current tooltip overlay entry.
  OverlayEntry? tooltipOverlayEntry;

  /// The current tooltip animation controller.
  AnimationController? tooltipAnimationController;

  /// The current mouse position.
  Offset? mousePosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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

    InteractableTooltip? tooltip = widget.interactable.onHover(widget.escapeGame).object;
    result = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        if (tooltip != null) {
          showTooltip(event, tooltip);
        }
        tooltipAnimationController?.forward(from: widget.interactable.renderSettings?.hoverAnimation?.from);
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
        tooltipAnimationController?.reset();
      },
      child: Listener(
        onPointerUp: (event) => widget.onInteractableTapped(context),
        behavior: HitTestBehavior.translucent,
        child: InteractableAnimationWidget(
          animation: widget.interactable.renderSettings?.enterAnimation,
          child: InteractableAnimationWidget(
            animation: widget.interactable.renderSettings?.hoverAnimation,
            controller: (controller) => tooltipAnimationController = controller,
            animate: false,
            child: AutoImage.fromRenderSettings(renderSettings: widget.interactable.renderSettings),
          ),
        ),
      ),
    );

    return result;
  }

  @override
  void dispose() {
    if (tooltipOverlayEntry != null) {
      tooltipOverlayEntry?.remove();
      tooltipOverlayEntry = null;
    }
    widget.interactable.removeListener(refreshState);
    super.dispose();
  }

  /// Shows the specified [tooltip].
  void showTooltip(PointerEvent event, InteractableTooltip tooltip) {
    updateTooltipPosition(event);
    tooltipOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: tooltip.calculateY(mousePosition!),
        left: tooltip.calculateX(mousePosition!),
        child: AnimatedOpacity(
          opacity: tooltipOpacity,
          duration: const Duration(milliseconds: 200),
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                tooltip.text,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      opaque: false,
    );
    Overlay.of(context)?.insert(tooltipOverlayEntry!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tooltipOpacity = 1;
      tooltipOverlayEntry?.markNeedsBuild();
    });
  }

  /// Updates the current tooltip position.
  void updateTooltipPosition(PointerEvent event) {
    Offset? previousPosition = mousePosition;
    mousePosition = event.position;
    if (previousPosition != mousePosition) {
      tooltipOverlayEntry?.markNeedsBuild();
    }
  }

  /// Hides the current tooltip.
  Future<void> hideTooltip(PointerEvent event) async {
    OverlayEntry? tooltipOverlayEntry = this.tooltipOverlayEntry;
    if (tooltipOverlayEntry != null) {
      this.tooltipOverlayEntry = null;
      tooltipOpacity = 0;
      tooltipOverlayEntry.markNeedsBuild();
      await Future.delayed(const Duration(milliseconds: 200));
      tooltipOverlayEntry.remove();
    }
  }

  /// Refreshes the widget state.
  void refreshState() {
    if (mounted) {
      setState(() {});
    }
  }
}
