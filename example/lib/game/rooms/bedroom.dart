import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/bed_key.dart';
import 'package:escape_game_kit_example/game/objects/painting_key.dart';
import 'package:escape_game_kit_example/game/padlocks/computer_padlock.dart';

class BedroomRoom extends Room {
  static const String roomId = 'bedroom';

  BedroomRoom({
    EscapeGameObject paintingKey = const PaintingKey(),
  }) : super(
          id: roomId,
          firstVisitDialog: const EscapeGameDialog(message: "Mince, que s'est-il passé ?<br>Et surtout, où est-on !?"),
          interactables: [
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
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Vers le bureau')),
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
              onHover: (escapeGame) => const ActionResult.success(
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
                    password: '146',
                    caseSensitive: false,
                    title: 'Connexion',
                    unlockMessage: 'Mince, il faut se connecter !',
                    failedToUnlockMessage: 'Impossible de se connecter... Il doit y avoir une erreur quelque part.',
                  ),
                  ComputerPadlock(),
                ],
              ),
            ),
            Interactable(
              id: 'mirror',
              renderSettings: const InteractableRenderSettings(
                top: 130,
                left: 280,
                height: 80,
                width: 60,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un grand miroir.')),
            ),
            Interactable(
              id: 'top-drawers',
              renderSettings: const InteractableRenderSettings(
                top: 290,
                left: 250,
                height: 30,
                width: 70,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "Il n'y a rien dans les deux tiroirs du dessus.")),
            ),
            PickableObject(
              object: paintingKey,
              renderSettings: const InteractableRenderSettings(
                top: 320,
                left: 250,
                height: 15,
                width: 70,
              ),
              onPickedUp: (escapeGame) {
                escapeGame.openDialog(EscapeGameDialog(
                  title: 'Object trouvé !',
                  imageRenderSettings: RenderSettings(
                    asset: paintingKey.inventoryRenderSettings?.asset,
                    width: 100,
                    height: 100,
                  ),
                  message: 'Vous avez trouvé une clé !',
                ));
                return const ActionResult.success();
              },
              removedTooltip: const InteractableTooltip(text: 'Vous avez trouvé une clé dans ce tiroir.'),
            ),
            Interactable(
              id: 'wardrobe',
              renderSettings: const InteractableRenderSettings(
                top: 143,
                left: 100,
                height: 217,
                width: 100,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Ce n\'est qu\'une armoire.')),
            ),
            Interactable(
              id: 'window',
              renderSettings: const InteractableRenderSettings(
                top: 134,
                left: 424,
                height: 213,
                width: 122,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Il fait encore nuit dehors.')),
            ),
            Clue.dialog(
              id: 'bed-chest',
              renderSettings: const InteractableRenderSettings(
                top: 279,
                left: 636,
                height: 78,
                width: 288,
              ),
              keyId: BedKey.objectId,
              clueDialog: const EscapeGameDialog(message: '<em>Des lapins et des poules courent dans le jardin. On ne sait pas combien il y en a, mais on compte 20 pattes et 6 têtes.</em><br><br>Le deuxième chiffre du mot de passe est le nombre de lapins.'),
              noKeyDialog: const EscapeGameDialog(message: 'Il semble y avoir un coffre sous ce lit, mais il est verouillé par une clé...'),
            ),
            Clue.dialog(
              id: 'lamp',
              renderSettings: const InteractableRenderSettings(
                top: 230,
                left: 288,
                height: 44,
                width: 38,
              ),
              clueDialog: const EscapeGameDialog(message: "Tiens, il y a un indice derrière cette lampe !<br><br><em>Je n'arrêtais jamais de perdre le code du cadenas du coffre caché dans le pot de fleur en bas... Mais maintenant plus de soucis !<br>Pour le déverrouiller, il suffit d'entrer le nombre de combinaisons de codes à 3 chiffres possibles !</em>"),
            ),
          ],
        );
}
