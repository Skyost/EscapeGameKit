import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:escape_game_kit/src/widgets/room/background.dart';
import 'package:escape_game_kit/src/widgets/room/create_interactable_dialog.dart';
import 'package:escape_game_kit/src/widgets/room/interactable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef BackgroundWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, Room room);
typedef InteractableWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, Room room, Interactable interactable);

class RoomWidget extends StatefulWidget {
  final EscapeGame escapeGame;
  final Room room;
  final BackgroundWidgetBuilder backgroundWidgetBuilder;
  final InteractableWidgetBuilder interactableWidgetBuilder;

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

  static Widget defaultBackgroundWidgetBuilder(BuildContext context, EscapeGame escapeGame, Room room) => RoomBackgroundWidget(
        room: room,
      );

  static Widget defaultInteractableWidgetBuilder(BuildContext context, EscapeGame escapeGame, Room room, Interactable interactable) => InteractableWidget(
        escapeGame: escapeGame,
        interactable: interactable,
      );
}

class _RoomWidgetState extends State<RoomWidget> {
  Offset? firstCorner;
  Offset? secondCorner;
  Rect? debugRect;
  Size? widgetSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
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
          RenderSettingsStackWidget(
            renderSettings: widget.room.renderSettings,
            child: widget.backgroundWidgetBuilder(context, widget.escapeGame, widget.room),
          ),
          if (translucentRectangle != null)
            Positioned.fromRect(
              rect: translucentRectangle!,
              child: Tooltip(
                message: 'Top: ${translucentRectangle!.top.round()} ; left: ${translucentRectangle!.left.round()}.\nWidth: ${translucentRectangle!.width.round()} ; height : ${translucentRectangle!.height.round()}.',
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateInteractableDialog(translucentRectangle: translucentRectangle!),
                    );
                  },
                  child: Container(color: Colors.teal.withOpacity(0.5)),
                ),
              ),
            ),
          if (kDebugMode)
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (details) {
                  if (translucentRectangle == null || !translucentRectangle!.contains(details.position)) {
                    setState(() {
                      firstCorner = details.position;
                      secondCorner = null;
                    });
                  }
                },
                onPointerMove: (details) {
                  if (firstCorner != null) {
                    setState(() => secondCorner = details.position);
                  }
                },
                onPointerUp: (details) {
                  if (translucentRectangle == null || !translucentRectangle!.contains(details.position)) {
                    setState(() => secondCorner = details.position);
                  }
                },
              ),
            ),
          for (Interactable interactable in widget.room.interactables)
            RenderSettingsStackWidget(
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

  Rect? get translucentRectangle => firstCorner == null || secondCorner == null ? null : Rect.fromPoints(firstCorner!, secondCorner!);

  void refreshState() {
    setState(() {});
  }
}
