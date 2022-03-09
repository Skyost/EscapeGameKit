import 'package:escape_game_kit/escape_game_kit.dart';

const EscapeGameObject key = EscapeGameObject(
  id: 'key',
  name: 'Key',
);

final Room _bedroom = Room(
  id: 'bedroom',
  interactables: [
    Interactable(
      id: 'invisible-1',
      renderSettings: const PositionedRenderSettings(
        top: 130,
        left: 280,
        height: 80,
        width: 60,
      ),
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: 'A big mirror.'),
    ),
    Interactable(
      id: 'invisible-2',
      renderSettings: const PositionedRenderSettings(
        top: 290,
        left: 250,
        height: 30,
        width: 70,
      ),
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: "There's nothing in the first two draws."),
    ),
    PickableObject(
      id: 'key',
      object: key,
      renderSettings: const PositionedRenderSettings(
        top: 320,
        left: 250,
        height: 15,
        width: 70,
      ),
      onPickedUp: (escapeGame) {
        escapeGame.openDialog(const EscapeGameDialog(message: "You've found a key !"));
        return const ActionResult.success();
      }
    ),
    Door(
      id: 'final-door',
      renderSettings: const PositionedRenderSettings(
        top: 225,
        left: 410,
        height: 60,
        width: 60,
      ),
      roomId: 'final',
      padlock: PatternPadlock(
        dimension: 3,
        validPattern: [
          PatternCoordinate(x: 0, y: 0),
          PatternCoordinate(x: 1, y: 0),
        ],
      ),
    ),
  ],
);

final EscapeGame escapeGame = EscapeGame(
  firstRoomId: _bedroom.id,
  rooms: [
    _bedroom,
  ],
);
