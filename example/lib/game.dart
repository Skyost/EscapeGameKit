import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/rooms/bedroom.dart';
import 'package:escape_game_kit_example/rooms/bedroom_present.dart';
import 'package:escape_game_kit_example/rooms/desk.dart';
import 'package:escape_game_kit_example/rooms/linving_room.dart';

final EscapeGame escapeGame = EscapeGame(
  firstRoomId: bedroom.id,
  rooms: [
    bedroomPresent,
    bedroom,
    desk,
    livingRoom,
  ],
  inventory: Inventory(
    title: 'Inventaire',
    emptyMessage: "Vous n'avez rien dans votre inventaire.",
  ),
);
