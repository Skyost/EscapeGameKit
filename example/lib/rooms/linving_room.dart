import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/objects/lamp_key.dart';

final Room livingRoom = Room(
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
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Vers la chambre')),
      roomId: 'bedroom',
    ),
    PickableObject(
      id: 'lamp-key',
      renderSettings: const InteractableRenderSettings(
        top: 302,
        left: 610,
        height: 38,
        width: 38,
      ),
      object: lampKey,
      padlock: DigitsPadlock(
        title: 'Entrer le code',
        unlockMessage: 'Ce placard est protégé par un cadenas !',
        failedToUnlockMessage: "Mince, ce n'est pas le bon code...",
        digits: '120',
      ),
      onPickedUp: (escapeGame) {
        escapeGame.openDialog(const EscapeGameDialog(
          title: 'Object trouvé !',
          imageRenderSettings: RenderSettings(
            asset: 'assets/interactables/lamp-key.svg',
            width: 100,
            height: 100,
          ),
          message: 'Vous avez trouvé une clé !',
        ));
        return const ActionResult.success();
      },
    ),
  ],
);
