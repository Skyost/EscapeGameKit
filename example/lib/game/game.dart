import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/rooms/bedroom.dart';
import 'package:escape_game_kit_example/game/rooms/bedroom_present.dart';
import 'package:escape_game_kit_example/game/rooms/desk.dart';
import 'package:escape_game_kit_example/game/rooms/linving_room.dart';
import 'package:flutter/foundation.dart';

class Error1980EscapeGame extends EscapeGame {
  Error1980EscapeGame()
      : super(
          firstRoomId: kDebugMode ? BedroomRoom.roomId : null, // TODO: Remove this one.
          rooms: [
            BedroomPresentRoom(),
            BedroomRoom(),
            DeskRoom(),
            LinvingRoomRoom(),
          ],
          inventory: Inventory(
            title: 'Inventaire',
            emptyMessage: "Vous n'avez rien dans votre inventaire.",
          ),
        );
}
