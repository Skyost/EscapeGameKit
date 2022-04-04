import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/bed_key.dart';
import 'package:escape_game_kit_example/game/objects/painting_key.dart';
import 'package:escape_game_kit_example/game/padlocks/bruteforce_padlock.dart';
import 'package:escape_game_kit_example/game/padlocks/computer_padlock.dart';

class BedroomRoom extends Room {
  static const String roomId = 'bedroom';

  BedroomRoom({
    EscapeGameObject deskKey = const DeskKey(),
  }) : super(
          id: roomId,
          firstVisitDialog: const EscapeGameDialog(message: "<em>Mince, que s'est-il passé ?<br>Et surtout, où est-on !?</em>"),
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
              onTap: (escapeGame) {
                if (!escapeGame.inventory.hasObject(deskKey)) {
                  escapeGame.openDialog(const EscapeGameDialog(
                    title: 'Porte verrouillée',
                    message: "<em>Mince, la porte de la bibliothèque est verrouillée, et vous n'avez pas la clé !</em>",
                  ));
                  return const ActionResult.failed();
                }
                return const ActionResult.success();
              },
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
              onTap: (escapeGame) {
                if (!escapeGame.inventory.hasObject(deskKey)) {
                  escapeGame.openDialog(const EscapeGameDialog(
                    title: 'Porte verrouillée',
                    message: "<em>Mince, la porte du salon est verrouillée, et vous n'avez pas la clé !</em>",
                  ));
                  return const ActionResult.failed();
                }
                return const ActionResult.success();
              },
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Vers le salon',
                  xShift: -20,
                ),
              ),
              roomId: 'living-room',
            ),
            Door(
              id: 'computer',
              renderSettings: const InteractableRenderSettings(
                top: 225,
                left: 410,
                height: 60,
                width: 60,
              ),
              roomId: 'bedroom-final',
              padlock: PadlockSequence(
                padlocks: [
                  CredentialsPadlock(
                    username: 'shtam',
                    password: '146',
                    caseSensitive: false,
                    title: 'Connexion',
                    unlockMessage: 'Zut, il faut se connecter !',
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
              object: deskKey,
              renderSettings: const InteractableRenderSettings(
                top: 320,
                left: 250,
                height: 15,
                width: 70,
              ),
              padlock: BruteforcePadlock(),
              onPickedUp: (escapeGame) {
                escapeGame.openDialog(EscapeGameDialog(
                  title: 'Objet trouvé !',
                  imageRenderSettings: RenderSettings(
                    asset: deskKey.inventoryRenderSettings?.asset,
                    width: 100,
                    height: 100,
                  ),
                  message: '<em>Vous avez trouvé une clé en forme de bouche !</em>',
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
              clueDialog: const EscapeGameDialog(
                title: 'Indice sur le mot de passe',
                message: "<em>Vous avez déverrouillé ce coffre à l'aide de la clé en forme de huit... Et il contient un message !</em><br><br>Des lapins et des poules courent dans le jardin. On ne sait pas combien il y en a, mais on compte 20 pattes et 6 têtes.<br><br><strong>Le deuxième chiffre du mot de passe de l'ordinateur est le nombre de lapins.</strong>",
              ),
              noKeyDialog: const EscapeGameDialog(
                title: 'Coffre verrouillé',
                message: '<em>Il semble y avoir un coffre sous ce lit, mais il est verouillé par une clé...</em>',
              ),
            ),
            Clue.dialog(
              id: 'lamp',
              renderSettings: const InteractableRenderSettings(
                top: 230,
                left: 288,
                height: 44,
                width: 38,
              ),
              clueDialog: const EscapeGameDialog(
                title: 'Indice sur un cadenas',
                message: "<em>Tiens, il y a un indice derrière cette lampe !</em><br><br>Je n'arrêtais jamais d'oublier le code du cadenas du coffre caché dans le pot de fleur du salon... Mais maintenant plus de souci !<br>Pour le déverrouiller, il suffit d'entrer le nombre de combinaisons de codes à 3 chiffres possibles !",
              ),
            ),
            Interactable(
              id: 'candles',
              renderSettings: const InteractableRenderSettings(
                top: 218,
                left: 247,
                height: 55,
                width: 31,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Des bougies éclairent la pièce.')),
            ),
          ],
        );
}
