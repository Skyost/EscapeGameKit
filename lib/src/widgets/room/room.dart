import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/widgets/render_settings.dart';
import 'package:escape_game_kit/src/widgets/room/background.dart';
import 'package:escape_game_kit/src/widgets/room/create_interactable_dialog.dart';
import 'package:escape_game_kit/src/widgets/room/interactable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef BackgroundWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, Room room);
typedef InteractableWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, Room room, Interactable interactable);

/// Allows to render a [Room].
class RoomWidget extends StatefulWidget {
  /// The [EscapeGame] instance.
  final EscapeGame escapeGame;

  /// The room.
  final Room room;

  /// The background widget builder.
  final BackgroundWidgetBuilder backgroundWidgetBuilder;

  /// The interactable widget builder.
  final InteractableWidgetBuilder interactableWidgetBuilder;

  /// Creates a new [RoomWidget] instance.
  RoomWidget({
    Key? key,
    required this.escapeGame,
    required this.room,
    this.backgroundWidgetBuilder = defaultBackgroundWidgetBuilder,
    this.interactableWidgetBuilder = defaultInteractableWidgetBuilder,
  }) : super(
          key: key ?? ValueKey<String>('room-${room.id}'),
        );

  @override
  State<StatefulWidget> createState() => _RoomWidgetState();

  /// The default [Room] background widget builder.
  static Widget defaultBackgroundWidgetBuilder(BuildContext context, EscapeGame escapeGame, Room room) => RoomBackgroundWidget(
        room: room,
      );

  /// The default [Interactable] widget builder.
  static Widget defaultInteractableWidgetBuilder(BuildContext context, EscapeGame escapeGame, Room room, Interactable interactable) => InteractableWidget(
        escapeGame: escapeGame,
        interactable: interactable,
      );
}

/// The [RoomWidget] state.
class _RoomWidgetState extends State<RoomWidget> {
  /// The first corner of the translucent rectangle.
  Offset? firstCorner;

  /// The second corner of the translucent rectangle.
  Offset? secondCorner;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.room.addListener(refreshState);
    });
  }

  @override
  void didUpdateWidget(covariant RoomWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.escapeGame != widget.escapeGame || oldWidget.room != widget.room) {
      refreshState();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          RenderSettingsWidget(
            renderSettings: widget.room.renderSettings,
            child: widget.backgroundWidgetBuilder(context, widget.escapeGame, widget.room),
          ),
          if (translucentRectangle != null)
            Positioned.fromRect(
              rect: translucentRectangle!,
              child: Tooltip(
                message: 'Top: ${translucentRectangle!.top.round()} ; left: ${translucentRectangle!.left.round()}.\nWidth: ${translucentRectangle!.width.round()} ; height : ${translucentRectangle!.height.round()}.',
                child: GestureDetector(
                  onTap: () => CreateInteractableDialog.openDialog(context, translucentRectangle: translucentRectangle!),
                  child: Container(color: Colors.teal.withOpacity(0.5)),
                ),
              ),
            ),
          if (kDebugMode)
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (details) {
                  if (translucentRectangle == null || !translucentRectangle!.contains(details.localPosition)) {
                    setState(() {
                      firstCorner = details.localPosition;
                      secondCorner = null;
                    });
                  }
                },
                onPointerMove: (details) {
                  if (firstCorner != null) {
                    setState(() => secondCorner = details.localPosition);
                  }
                },
                onPointerUp: (details) {
                  if (translucentRectangle == null || !translucentRectangle!.contains(details.localPosition)) {
                    setState(() => secondCorner = details.localPosition);
                  }
                },
              ),
            ),
          for (Interactable interactable in widget.room.interactables)
            RenderSettingsWidget(
              renderSettings: interactable.renderSettings,
              child: widget.interactableWidgetBuilder(context, widget.escapeGame, widget.room, interactable),
            )
        ],
      );

  @override
  void dispose() {
    widget.escapeGame.removeListener(refreshState);
    super.dispose();
  }

  /// Returns the translucent rectangle (built with [firstCorner] and [secondCorner]).
  Rect? get translucentRectangle => firstCorner == null || secondCorner == null ? null : Rect.fromPoints(firstCorner!, secondCorner!);

  /// Refreshes the widget state.
  void refreshState() {
    if (mounted) {
      setState(() {});
    }
  }
}
