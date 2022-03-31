import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/objects/painting_key.dart';

final Room bedroom = Room(
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
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: 'Un grand miroir.'),
    ),
    Interactable(
      id: 'invisible-2',
      renderSettings: const InteractableRenderSettings(
        top: 290,
        left: 250,
        height: 30,
        width: 70,
      ),
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: "Il n'y a rien dans les deux premiers tiroirs."),
    ),
    PickableObject(
        id: 'key',
        object: paintingKey,
        renderSettings: const InteractableRenderSettings(
          top: 320,
          left: 250,
          height: 15,
          width: 70,
        ),
        onPickedUp: (escapeGame) {
          escapeGame.openDialog(const EscapeGameDialog(
            title: 'Object trouvé !',
            imageRenderSettings: RenderSettings(
              asset: 'assets/interactables/key.svg',
              width: 100,
              height: 100,
            ),
            message: 'Vous avez trouvé une clé !',
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
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: 'Vers le bureau'),
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
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: 'Vers le salon'),
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
