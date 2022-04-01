import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/objects/painting_key.dart';
import 'package:escape_game_kit_example/padlocks/computer_padlock.dart';

final Room bedroom = Room(
  id: 'bedroom',
  firstVisitDialog: const EscapeGameDialog(message: "Mince, que s'est-il passé ?<br>Et surtout, où est-on !?"),
  interactables: [
    Interactable(
      id: 'mirror',
      renderSettings: const InteractableRenderSettings(
        top: 130,
        left: 280,
        height: 80,
        width: 60,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un grand miroir.')),
    ),
    Interactable(
      id: 'top-draws',
      renderSettings: const InteractableRenderSettings(
        top: 290,
        left: 250,
        height: 30,
        width: 70,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "Il n'y a rien dans les deux tiroirs du dessus.")),
    ),
    PickableObject(
      id: 'painting-key',
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
            asset: 'assets/interactables/painting-key.svg',
            width: 100,
            height: 100,
          ),
          message: 'Vous avez trouvé une clé !',
        ));
        return const ActionResult.success();
      },
    ),
    Interactable(
      id: 'wardrobe',
      renderSettings: const InteractableRenderSettings(
        top: 143,
        left: 100,
        height: 217,
        width: 100,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Ce n\'est qu\'une armoire.')),
    ),
    Interactable(
      id: 'window',
      renderSettings: const InteractableRenderSettings(
        top: 134,
        left: 424,
        height: 213,
        width: 122,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Il fait encore nuit dehors.')),
    ),
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
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Vers le bureau')),
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
      onTooltip: (escapeGame) => const ActionResult.success(
        object: InteractableTooltip(
          text: 'Vers le salon',
          xShift: -20,
        ),
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
      padlock: PadlockSequence(
        padlocks: [
          CredentialsPadlock(
            username: 'shtam',
            password: 'jadorelesmaths',
            caseSensitive: false,
            title: 'Connexion',
            unlockMessage: 'Mince, il faut se connecter !',
            failedToUnlockMessage: 'Impossible de se connecter... Il doit y avoir une erreur quelque part.'
          ),
          ComputerPadlock(),
        ],
      ),
    ),
  ],
);
