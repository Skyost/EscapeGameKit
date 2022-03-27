import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';

final EscapeGameObject _key = EscapeGameObject(
  id: 'key',
  name: 'Key',
);

final Room _bedroom = Room(
  id: 'bedroom',
  interactables: [
    Interactable(
      id: 'invisible-1',
      renderSettings: const InteractableRenderSettings(
        top: 130,
        left: 280,
        height: 80,
        width: 60,
      ),
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: 'A big mirror.'),
    ),
    Interactable(
      id: 'invisible-2',
      renderSettings: const InteractableRenderSettings(
        top: 290,
        left: 250,
        height: 30,
        width: 70,
      ),
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: "There's nothing in the first two draws."),
    ),
    PickableObject(
        id: 'key',
        object: _key,
        renderSettings: const InteractableRenderSettings(
          top: 320,
          left: 250,
          height: 15,
          width: 70,
        ),
        onPickedUp: (escapeGame) {
          escapeGame.openDialog(const EscapeGameDialog(
            title: 'Item found',
            imageRenderSettings: RenderSettings(
              asset: 'assets/interactables/key.svg',
              width: 100,
              height: 100,
            ),
            message: "You've found a key !",
          ));
          return const ActionResult.success();
        }),
    Door(
      id: 'desk-door',
      renderSettings: InteractableRenderSettings(
        asset: 'assets/interactables/arrow.svg',
        top: 200,
        left: 20,
        height: 80,
        width: 80,
        rotationAngle: -pi / 2 - 0.2,
        hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
      ),
      roomId: 'desk',
    ),
    Door(
      id: 'living-room-door',
      renderSettings: InteractableRenderSettings(
        asset: 'assets/interactables/arrow.svg',
        top: 200,
        right: 20,
        height: 80,
        width: 80,
        rotationAngle: pi / 2 + 0.2,
        hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
      ),
      roomId: 'living-room',
    ),
    Door(
      id: 'final-door',
      renderSettings: const InteractableRenderSettings(
        top: 225,
        left: 410,
        height: 60,
        width: 60,
      ),
      roomId: 'final',
      padlock: CredentialsPadlock(
        username: 'Skyost',
        password: 'EscapeGameKit',
        caseSensitive: false,
      ),
    ),
  ],
);

final Room _desk = Room(
  id: 'desk',
  interactables: [
    Door(
      id: 'bedroom-door',
      renderSettings: InteractableRenderSettings(
        asset: 'assets/interactables/arrow.svg',
        top: 200,
        right: 20,
        height: 80,
        width: 80,
        rotationAngle: pi / 2 + 0.2,
        hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
      ),
      roomId: 'bedroom',
    ),
  ],
);

final Room _livingRoom = Room(
  id: 'living-room',
  interactables: [
    Door(
      id: 'bedroom-door',
      renderSettings: InteractableRenderSettings(
        asset: 'assets/interactables/arrow.svg',
        top: 100,
        left: 20,
        height: 80,
        width: 80,
        rotationAngle: -1,
        hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
      ),
      roomId: 'bedroom',
    ),
  ],
);

final EscapeGame escapeGame = EscapeGame(
  firstRoomId: _bedroom.id,
  rooms: [
    _bedroom,
    _desk,
    _livingRoom,
  ],
);
