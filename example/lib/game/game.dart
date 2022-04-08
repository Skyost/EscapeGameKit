import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/messages/messages.dart';
import 'package:escape_game_kit_example/game/rooms/bedroom.dart';
import 'package:escape_game_kit_example/game/rooms/bedroom_final.dart';
import 'package:escape_game_kit_example/game/rooms/bedroom_present.dart';
import 'package:escape_game_kit_example/game/rooms/desk.dart';
import 'package:escape_game_kit_example/game/rooms/linving_room.dart';

/// The [EscapeGame] class.
class Error1980EscapeGame extends EscapeGame {
  /// All messages shown in the [MessagesDialog].
  final Messages messages = Messages();

  /// Creates a new [Error1980EscapeGame] instance.
  Error1980EscapeGame()
      : super(
          rooms: [
            BedroomPresentRoom(),
            BedroomRoom(),
            DeskRoom(),
            LinvingRoomRoom(),
            BedroomFinalRoom(),
          ],
          inventory: Inventory(),
        );
}
