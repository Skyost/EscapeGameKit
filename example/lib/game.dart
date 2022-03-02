import 'package:escape_game_kit/escape_game_kit.dart';

final Room _bedroom = Room(
  id: 'bedroom',
  interactables: [
    Interactable(
      id: 'invisible-1',
      renderSettings: const PositionedRenderSettings(
        top: 50,
        left: 50,
        height: 100,
        width: 100,
      ),
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: 'Test !'),
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
      padlock: DigitsPadlock(digits: 'test'),
    ),
  ],
);

final EscapeGame escapeGame = EscapeGame(
  firstRoomId: _bedroom.id,
  rooms: [
    _bedroom,
  ],
);
