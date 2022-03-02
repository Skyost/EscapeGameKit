import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:escape_game_kit/src/widgets/room/background.dart';
import 'package:escape_game_kit/src/widgets/room/interactable.dart';
import 'package:flutter/material.dart';

typedef BackgroundWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, Room room);
typedef InteractableWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, Room room, Interactable interactable);

class RoomWidget extends StatelessWidget {
  final EscapeGame escapeGame;
  final Room room;
  final BackgroundWidgetBuilder backgroundWidgetBuilder;
  final InteractableWidgetBuilder interactableWidgetBuilder;

  const RoomWidget({
    Key? key,
    required this.escapeGame,
    required this.room,
    this.backgroundWidgetBuilder = defaultBackgroundWidgetBuilder,
    this.interactableWidgetBuilder = defaultInteractableWidgetBuilder,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          RenderSettingsStackWidget(
            renderSettings: room.renderSettings,
            child: backgroundWidgetBuilder(context, escapeGame, room),
          ),
          for (Interactable interactable in room.interactables)
            RenderSettingsStackWidget(
              renderSettings: interactable.renderSettings,
              child: interactableWidgetBuilder(context, escapeGame, room, interactable),
            )
        ],
      );

  static Widget defaultBackgroundWidgetBuilder(BuildContext context, EscapeGame escapeGame, Room room) => RoomBackgroundWidget(
        room: room,
      );

  static Widget defaultInteractableWidgetBuilder(BuildContext context, EscapeGame escapeGame, Room room, Interactable interactable) => InteractableWidget(
        escapeGame: escapeGame,
        interactable: interactable,
      );
}
