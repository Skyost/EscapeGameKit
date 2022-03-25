import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:escape_game_kit/src/widgets/room/background.dart';
import 'package:escape_game_kit/src/widgets/room/interactable.dart';
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

  void refreshState() {
    setState(() {});
  }
}
